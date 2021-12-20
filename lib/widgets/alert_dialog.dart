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
    this.onCancel,
    this.onConfirm,
  }) : super(key: key);

  final BluetoothDevice device;
  final Widget? child;
  final String? title;
  final Function? onCancel;
  final Function? onConfirm;

  @override
  State<AppAlertDialog> createState() => _AppAlertDialogState();
}

class _AppAlertDialogState extends State<AppAlertDialog> {
  final String SERVICE_UUID = "4fafc201-1fb5-459e-8fcc-c5c9c331914b";
  final String CHARACTERISTIC_UUID_NOTIFY =
      "beb5483e-36e1-4688-b7f5-ea07361b26a8";
  final String CHARACTERISTIC_UUID_WRITE =
      "828917c1-ea55-4d4a-a66e-fd202cea0645";
  bool? isReady;
  Stream<List<int>>? stream;
  var notifyValue;

  writeDataAndWaitForRespond() async {
    List<BluetoothService> services = await widget.device.discoverServices();
    services.forEach((service) async {
      if (service.uuid.toString() == SERVICE_UUID) {
        var characteristics = service.characteristics;
        for (var characteristic in characteristics) {
          if (characteristic.uuid.toString() == CHARACTERISTIC_UUID_NOTIFY) {
            await characteristic.setNotifyValue(true);
            characteristic.value.listen((value) {
              notifyValue = value;
            });
            if (notifyValue == 0) {
              setState(() {
                isReady = true;
              });
            } else {
              setState(() {
                isReady = false;
              });
            }
          } else if (characteristic.uuid.toString() ==
              CHARACTERISTIC_UUID_WRITE) {
            await characteristic.write([0x30]);
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text('ทำการทดสอบ ${widget.title}'),
          actions: [
            TextButton(
              onPressed: () {
                print('ยกเลิก');
                widget.onCancel;
                Navigator.pop(context);
              },
              child: const Text('ยกเลิก'),
              style: TextButton.styleFrom(primary: Colors.black),
            ),
            TextButton(
              onPressed: () {
                print('confirm');
                widget.onConfirm;
                writeDataAndWaitForRespond();
                Navigator.pop(context);
              },
              child: const Text('ตกลง'),
              style: TextButton.styleFrom(primary: Colors.blue),
            ),
          ],
        ),
      ),
      child: widget.child,
    );
  }
}
