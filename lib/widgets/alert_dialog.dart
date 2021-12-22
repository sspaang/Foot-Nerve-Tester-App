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
  String? notifyValue;
  int? command;
  bool? isFinised;
  Timer? _timer;
  List<String> listenList = [];

  static const checkImage = AssetImage('assets/images/check.png');

  @override
  void initState() {
    super.initState();
    isFinised = false;
    EasyLoading.addStatusCallback((status) {
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
          if (characteristic.properties.notify) {
            await characteristic.setNotifyValue(true);
            if (!listenList.contains(widget.device.id.toString())) {
              listenList.add(widget.device.id.toString());
              characteristic.value.listen((value) {
                notifyValue = _dataParser(value);
                print('Notify value: $notifyValue');

                if (notifyValue == '1') {
                  _showWorkingDialog();
                } else if (notifyValue == '0') {
                  _hideDialog();
                  _showSelectTestingResultDialog();
                }
              });
            }
          } else if (characteristic.properties.write) {
            // OR define characteristic uuid in CharacteristicUUIDWrite and
            // else if (characteristic.uuid.toString() == CharacteristicUUIDWrite)
            var sendCommand = utf8.encode(command.toString());
            await characteristic.write(sendCommand);
            print('Value sent: $sendCommand');
          }
        }
      }
    });
  }

  String _dataParser(dataFromDevice) {
    return utf8.decode(dataFromDevice);
  }

  _showWorkingDialog() {
    EasyLoading.show(
        status: 'เครื่องกำลังทำงาน', maskType: EasyLoadingMaskType.black);
  }

  _showSelectTestingResultDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              SizedBox(
                width: 60,
                height: 60,
                child: Image(
                  image: checkImage,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'คุณรู้สึกหรือไม่?',
                style: TextStyle(fontSize: 16),
              ),
            ],
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
                  writeDataAndWaitForNotification(5);
                  Navigator.pop(context);
                },
                child: const Text('ยกเลิก'),
                style: TextButton.styleFrom(primary: Colors.black),
              ),
              TextButton(
                onPressed: () {
                  writeDataAndWaitForNotification(0);
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
