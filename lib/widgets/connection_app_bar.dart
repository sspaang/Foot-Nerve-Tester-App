import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hive/hive.dart';
import '../screens/find_devices_screen.dart';
import '../screens/test_result_screen.dart';

class ConnectionAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ConnectionAppBar({Key? key, required this.device}) : super(key: key);

  final BluetoothDevice device;

  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(device.name),
      actions: <Widget>[
        StreamBuilder<BluetoothDeviceState>(
          stream: device.state,
          initialData: BluetoothDeviceState.connecting,
          builder: (c, snapshot) {
            VoidCallback? onPressed;
            String text;
            switch (snapshot.data) {
              case BluetoothDeviceState.connected:
                onPressed = () async {
                  EasyLoading.show(
                      status: 'กำลังตัดการเชื่อมต่อ',
                      maskType: EasyLoadingMaskType.black,
                      dismissOnTap: false);
                  await device.disconnect();
                  Hive.close();
                  EasyLoading.dismiss();
                  Navigator.popUntil(context, (route) => route.isFirst);
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const FindDevicesScreen(),
                    ),
                  );
                };
                text = 'DISCONNECT';
                break;
              case BluetoothDeviceState.disconnected:
                onPressed = () => device.connect();
                text = 'CONNECT';
                break;
              default:
                onPressed = null;
                text = snapshot.data.toString().substring(21).toUpperCase();
                break;
            }
            return TextButton(
                onPressed: onPressed,
                child: Text(
                  text,
                  style: Theme.of(context)
                      .primaryTextTheme
                      .button
                      ?.copyWith(color: Colors.black),
                ));
          },
        ),
      ],
    );
  }
}
