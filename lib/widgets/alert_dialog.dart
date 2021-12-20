import 'dart:async';
import 'dart:convert' show utf8;

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

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
  bool? isReady;
  Stream<List<int>>? stream;
  var notifyValue;

  writeDataAndWaitForRespond(int command) async {
    var command = widget.command!;
    List<BluetoothService> services = await widget.device.discoverServices();
    services.forEach((service) async {
      if (service.uuid.toString() == serviceUUID) {
        var characteristics = service.characteristics;
        for (var characteristic in characteristics) {
          if (characteristic.uuid.toString() == characteristicUUIDNotify) {
            await characteristic.setNotifyValue(true);
            characteristic.value.listen((value) {
              notifyValue = value;
              print('Notify value: $notifyValue'); // _Uint8ArrayView
            });
            if (notifyValue == [48]) {
              setState(() {
                isReady = true;
              });
            } else {
              setState(() {
                isReady = false;
              });
            }
          } else if (characteristic.uuid.toString() ==
              characteristicUUIDWrite) {
            await characteristic.write([command]);
            print('Value sent: $command');
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        writeDataAndWaitForRespond(widget.command!);
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Text('ทำการทดสอบ ${widget.title}'),
            actions: [
              TextButton(
                onPressed: () {
                  print('ยกเลิก');
                  writeDataAndWaitForRespond(0x35);
                  Navigator.pop(context);
                },
                child: const Text('ยกเลิก'),
                style: TextButton.styleFrom(primary: Colors.black),
              ),
              TextButton(
                onPressed: () {
                  print('confirm');
                  writeDataAndWaitForRespond(0x30);
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
