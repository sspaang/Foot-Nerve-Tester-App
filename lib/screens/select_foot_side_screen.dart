import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:foot_nerve_tester_app/widgets/connection_app_bar.dart';

class SelectFootSideScreen extends StatelessWidget {
  const SelectFootSideScreen({Key? key, required this.device})
      : super(key: key);

  final BluetoothDevice device;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ConnectionAppBar(
        device: device,
      ),
      body: Center(
        child: Column(
          children: [
            const Text("เลือกเท้าข้างที่จะทำการทดสอบ"),
            Row(
              children: [
                Column(
                  children: const [
                    // Image - onPressed
                    // Text
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
