import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import '../widgets/connection_app_bar.dart';
import '../widgets/circle_image.dart';
import '../widgets/view_result_button.dart';

class TestLeftSideScreen extends StatelessWidget {
  const TestLeftSideScreen({Key? key, required this.device}) : super(key: key);

  final BluetoothDevice device;

  @override
  Widget build(BuildContext context) {
    const footSpot = AssetImage('assets/images/foot-spot.png');

    return Scaffold(
      appBar: ConnectionAppBar(
        device: device,
      ),
      body: Container(
        margin: const EdgeInsetsDirectional.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'ทดสอบเท้าข้างซ้าย',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  CircleImage(image: footSpot),
                  CircleImage(image: footSpot),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  Text('จุดที่ 1'),
                  Text('จุดที่ 2'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  CircleImage(image: footSpot),
                  CircleImage(image: footSpot),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  Text('จุดที่ 3'),
                  Text('จุดที่ 4'),
                ],
              ),
            ),
            const ResultButton(),
          ],
        ),
      ),
    );
  }
}
