import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:foot_nerve_tester_app/widgets/connection_app_bar.dart';

class SelectFootSideScreen extends StatelessWidget {
  const SelectFootSideScreen({Key? key, required this.device})
      : super(key: key);

  static const routeName = 'select-foot-side';
  final BluetoothDevice device;

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    const rightFootPrint =
        Image(image: AssetImage('assets/images/right-footprint.png'));
    const leftFootPrint =
        Image(image: AssetImage('assets/images/left-footprint.png'));

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
                  onTap: () => print('left foot'),
                  child: Container(
                    alignment: Alignment.center,
                    child: leftFootPrint,
                    height: deviceSize.height * 0.15,
                    width: deviceSize.width * 0.25,
                  ),
                ),
                InkWell(
                  onTap: () => print('right foot'),
                  child: Container(
                    alignment: Alignment.center,
                    child: rightFootPrint,
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
            )
          ],
        ),
      ),
    );
  }
}
