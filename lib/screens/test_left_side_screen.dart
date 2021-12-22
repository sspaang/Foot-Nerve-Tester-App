import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import '../widgets/connection_app_bar.dart';
import '../widgets/circle_image.dart';
import '../widgets/view_result_button.dart';
import '../widgets/alert_dialog.dart';

class TestLeftSideScreen extends StatelessWidget {
  const TestLeftSideScreen({Key? key, required this.device}) : super(key: key);

  final BluetoothDevice device;

  @override
  Widget build(BuildContext context) {
    const firstFootSpot = AssetImage('assets/images/left-first-spot.png');
    const secondFootSpot = AssetImage('assets/images/left-second-spot.png');
    const thirdFootSpot = AssetImage('assets/images/left-third-spot.png');
    const fourthFootSpot = AssetImage('assets/images/left-fourth-spot.png');

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
                children: [
                  AppAlertDialog(
                    device: device,
                    command: 1,
                    title: 'จุดที่ 1',
                    child: const CircleImage(image: firstFootSpot),
                  ),
                  AppAlertDialog(
                    device: device,
                    command: 2,
                    title: 'จุดที่ 2',
                    child: const CircleImage(image: secondFootSpot),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  Text(
                    'จุดที่ 1',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'จุดที่ 2',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AppAlertDialog(
                    device: device,
                    command: 3,
                    title: 'จุดที่ 3',
                    child: const CircleImage(image: thirdFootSpot),
                  ),
                  AppAlertDialog(
                    device: device,
                    command: 4,
                    title: 'จุดที่ 4',
                    child: const CircleImage(image: fourthFootSpot),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  Text(
                    'จุดที่ 3',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'จุดที่ 4',
                    style: TextStyle(fontSize: 16),
                  ),
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
