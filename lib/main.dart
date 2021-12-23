import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import './screens/bluetooth_off_screen.dart';
import './screens/find_devices_screen.dart';

void main() {
  runApp(const FlutterBlueApp());
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.light
    ..indicatorSize = 45.0
    ..radius = 5.0
    ..progressColor = Colors.black
    ..backgroundColor = Colors.black
    ..indicatorColor = Colors.blueAccent
    ..textColor = Colors.black
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
  // ..customAnimation = CustomAnimation();
}

class FlutterBlueApp extends StatelessWidget {
  const FlutterBlueApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Colors.lightGreen,
          onPrimary: Colors.black,
          primaryVariant: Colors.yellowAccent,
          secondary: Colors.blue,
          secondaryVariant: Colors.blueAccent,
          onSecondary: Colors.white,
          background: Colors.white,
          onBackground: Colors.white,
          surface: Colors.yellow,
          onSurface: Colors.black,
          error: Colors.red,
          onError: Colors.white,
        ),
        fontFamily: 'Prompt',
      ),
      color: Colors.lightBlue,
      home: StreamBuilder<BluetoothState>(
          stream: FlutterBlue.instance.state,
          initialData: BluetoothState.unknown,
          builder: (c, snapshot) {
            final state = snapshot.data;
            if (state == BluetoothState.on) {
              return const FindDevicesScreen();
            }
            return BluetoothOffScreen(state: state);
          }),
      builder: EasyLoading.init(),
    );
  }
}
