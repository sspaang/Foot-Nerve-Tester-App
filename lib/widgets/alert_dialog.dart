import 'dart:async';
import 'dart:convert' show utf8;

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class AppAlertDialog extends StatefulWidget {
  const AppAlertDialog({
    Key? key,
    required this.device,
    required this.title,
    required this.child,
    required this.command,
  }) : super(key: key);

  final BluetoothDevice device;
  final Widget? child;
  final String? title;
  final int? command;

  @override
  State<AppAlertDialog> createState() => _AppAlertDialogState();
}

class _AppAlertDialogState extends State<AppAlertDialog> {
  static const String serviceUUID = "4fafc201-1fb5-459e-8fcc-c5c9c331914b";
  static const String characteristicUUIDNotify =
      "beb5483e-36e1-4688-b7f5-ea07361b26a8";
  static const String characteristicUUIDWrite =
      "828917c1-ea55-4d4a-a66e-fd202cea0645";
  String? notifyValue;
  int? command;
  bool? isWorking;
  Timer? _timer;

  static const loadingSpin = AssetImage('assets/images/downloading-spin.gif');

  @override
  void initState() {
    super.initState();
    isWorking = false;
    EasyLoading.addStatusCallback((status) {
      print('EasyLoading Status $status');
      if (status == EasyLoadingStatus.dismiss) {
        _timer?.cancel();
      }
    });
  }

  writeDataAndWaitForNotification(int command) async {
    List<BluetoothService> services = await widget.device.discoverServices();
    services.forEach((service) async {
      if (service.uuid.toString() == serviceUUID) {
        var characteristics = service.characteristics;
        for (BluetoothCharacteristic characteristic in characteristics) {
          if (characteristic.uuid.toString() == characteristicUUIDNotify) {
            await characteristic.setNotifyValue(true);
            characteristic.value.listen(
              (value) {
                notifyValue = _dataParser(value);
                print('Notify value: $notifyValue');

                if (notifyValue == '1') {
                  _showWorkingDialog();
                } else if (notifyValue == '0') {
                  _hideDialog();
                  _showSelectTestingResultDialog();
                }
              },
            );
          } else if (characteristic.uuid.toString() ==
              characteristicUUIDWrite) {
            await characteristic.write([command]);
            print('Value sent: $command');
          }
        }
      }
    });
  }

  String _dataParser(dataFromDevice) {
    return utf8.decode(dataFromDevice);
  }

  _showWorkingDialog() {
    EasyLoading.showProgress(0.3, status: 'เครื่องกำลังทำงาน');
    // showDialog(
    //   context: context,
    //   barrierDismissible: false,
    //   builder: (BuildContext context) {
    //     return AlertDialog(
    //       title: const Center(child: Text('กรุณารอสักครู่')),
    //       content: Container(
    //         width: 60,
    //         height: 60,
    //         child: const Image(
    //           image: loadingSpin,
    //         ),
    //       ),
    //     );
    //   },
    // );
  }

  _showSelectTestingResultDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('คุณรู้สึกหรือไม่?'),
          content: Container(
            width: 60,
            height: 60,
            child: const Image(
              image: loadingSpin,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                print('ไม่รู้สึก');
                Navigator.pop(context);
              },
              child: const Text('ไม่รู้สึก'),
              style: TextButton.styleFrom(
                backgroundColor: Colors.red,
                primary: Colors.white,
              ),
            ),
            TextButton(
              onPressed: () {
                print('รู้สึก');
                Navigator.pop(context);
              },
              child: const Text('รู้สึก'),
              style: TextButton.styleFrom(
                backgroundColor: Colors.green,
                primary: Colors.white,
              ),
            ),
          ],
        );
      },
    );
  }

  _hideDialog() {
    if (EasyLoading.isShow) EasyLoading.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (command != widget.command) {
          writeDataAndWaitForNotification(widget.command!);
        }
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => AlertDialog(
            title: Text('ทำการทดสอบ ${widget.title}'),
            content: const Text('กรุณาวางส้นเท้าลงบนไฟ LED ที่แสดง'),
            actions: [
              TextButton(
                onPressed: () {
                  writeDataAndWaitForNotification(0x35);
                  Navigator.pop(context);
                },
                child: const Text('ยกเลิก'),
                style: TextButton.styleFrom(primary: Colors.black),
              ),
              TextButton(
                onPressed: () {
                  writeDataAndWaitForNotification(0x30);
                  Navigator.pop(context);
                },
                child: const Text('ตกลง'),
                style: TextButton.styleFrom(primary: Colors.blue),
              ),
            ],
          ),
        );
      },
      child: widget.child,
    );
  }
}
