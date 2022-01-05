import 'dart:async';
import 'dart:convert' show utf8;

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class AppAlertDialog extends StatefulWidget {
  const AppAlertDialog({
    Key? key,
    required this.device,
    required this.title,
    required this.child,
    required this.command,
  }) : super(key: key);

  final BluetoothDevice device;
  final String? title;
  final Widget? child;
  final int? command;

  @override
  State<AppAlertDialog> createState() => _AppAlertDialogState();
}

class _AppAlertDialogState extends State<AppAlertDialog> {
  static const String serviceUUID = "4fafc201-1fb5-459e-8fcc-c5c9c331914b";
  static const String notifyUUID = "beb5483e-36e1-4688-b7f5-ea07361b26a8";
  static const String writeUUID = "828917c1-ea55-4d4a-a66e-fd202cea0645";
  String? notifyValue;
  String? receiveValue;
  dynamic notifyStream;
  int? command;
  Timer? _timer;

  static const checkImage = AssetImage('assets/images/check.png');

  @override
  void initState() {
    print("initState");
    EasyLoading.addStatusCallback((status) {
      if (status == EasyLoadingStatus.dismiss) {
        _timer?.cancel();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    notifyStream!.close();
    print("dispose");
    super.dispose();
  }

  getNotifyValue() async {
    List<BluetoothService> services = await widget.device.discoverServices();
    for (BluetoothService service in services) {
      if (service.uuid.toString() == serviceUUID) {
        for (BluetoothCharacteristic characteristic
            in service.characteristics) {
          if (characteristic.uuid.toString() == notifyUUID) {
            await characteristic.setNotifyValue(true);
            notifyStream = characteristic.value.listen((value) {
              if (value.isNotEmpty) {
                notifyValue = _dataParser(value);
                print('Notify value: $notifyValue');

                if (notifyValue == '1') {
                  _showWorkingDialog();
                } else if (notifyValue == '0') {
                  _hideWorkingDialog();
                  _showSelectTestingResultDialog();
                }
              }
            });
          }
        }
      }
    }
  }

  writeData(int command) async {
    List<BluetoothService> services = await widget.device.discoverServices();
    for (BluetoothService service in services) {
      if (service.uuid.toString() == serviceUUID) {
        var characteristics = service.characteristics;
        for (BluetoothCharacteristic characteristic in characteristics) {
          if (characteristic.uuid.toString() == writeUUID) {
            var sendCommand = utf8.encode(command.toString());
            await characteristic.write(sendCommand);
            print('Value sent: $sendCommand');
          }
        }
      }
    }
  }

  String _dataParser(dataFromDevice) {
    return utf8.decode(dataFromDevice);
  }

  _showWorkingDialog() {
    EasyLoading.show(
      status: 'เครื่องกำลังทำงาน',
      maskType: EasyLoadingMaskType.black,
      dismissOnTap: false,
    );
  }

  _hideWorkingDialog() {
    if (EasyLoading.isShow) EasyLoading.dismiss();
  }

  _showSelectTestingResultDialog() {
    if (!Get.isDialogOpen!) _selectTestingResultDialog();
  }

  _selectTestingResultDialog() {
    Get.defaultDialog(
      barrierDismissible: false,
      radius: 5.0,
      content: Column(
        children: const [
          SizedBox(
            width: 40,
            height: 40,
            child: Image(
              image: checkImage,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'คุณรู้สึกหรือไม่?',
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            print('ไม่รู้สึก');
            Get.back();
          },
          child: const Text(
            "ไม่รู้สึก",
            style: TextStyle(fontSize: 16),
          ),
          style: ElevatedButton.styleFrom(
              primary: Colors.red, onPrimary: Colors.white),
        ),
        ElevatedButton(
          onPressed: () {
            print('รู้สึก');
            Get.back();
          },
          child: const Text(
            "รู้สึก",
            style: TextStyle(fontSize: 16),
          ),
          style: ElevatedButton.styleFrom(
              primary: Colors.green, onPrimary: Colors.white),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (command != widget.command) {
          writeData(widget.command!);
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
                  writeData(8); // turn off all LEDs
                  Navigator.pop(context);
                },
                child: const Text('ยกเลิก'),
                style: TextButton.styleFrom(primary: Colors.black),
              ),
              TextButton(
                onPressed: () async {
                  await writeData(0); // start working
                  getNotifyValue();
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
