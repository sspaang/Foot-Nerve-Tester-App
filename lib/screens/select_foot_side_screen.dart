import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

import './test_left_side_screen.dart';
import './test_right_side_screen.dart';
import '../widgets/connection_app_bar.dart';
import '../widgets/view_result_button.dart';
import '../widgets/evaluate_link_button.dart';

class SelectFootSideScreen extends StatelessWidget {
  const SelectFootSideScreen({Key? key, required this.device})
      : super(key: key);

  static const routeName = 'select-foot-side';
  final BluetoothDevice device;

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    const rightFootPrint = AssetImage('assets/images/right-footprint.png');
    const leftFootPrint = AssetImage('assets/images/left-footprint.png');

    return Scaffold(
      appBar: ConnectionAppBar(
        device: device,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "เลือกเท้าข้างที่จะทำการทดสอบ",
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) {
                      return TestLeftSideScreen(device: device);
                    }),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    child: const Image(image: leftFootPrint),
                    height: deviceSize.height * 0.15,
                    width: deviceSize.width * 0.25,
                  ),
                ),
                InkWell(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) {
                      return TestRightSideScreen(device: device);
                    }),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    child: const Image(image: rightFootPrint),
                    height: deviceSize.height * 0.15,
                    width: deviceSize.width * 0.25,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'เท้าซ้าย',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(
                  width: 30,
                ),
                Text(
                  'เท้าขวา',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const ResultButton(),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "คุณไม่ได้เป็นโรคเบาหวานใช่หรือไม่?",
              style: TextStyle(fontSize: 16),
            ),
            const EvaluateLinkButton(),
          ],
        ),
      ),
    );
  }
}
