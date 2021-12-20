import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

import './screens/bluetooth_off_screen.dart';
import './screens/find_devices_screen.dart';

void main() {
  runApp(const FlutterBlueApp());
}

class FlutterBlueApp extends StatelessWidget {
  const FlutterBlueApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Colors.yellow,
          onPrimary: Colors.black,
          primaryVariant: Colors.grey,
          secondary: Colors.grey,
          secondaryVariant: Colors.grey,
          onSecondary: Colors.grey,
          background: Colors.white,
          onBackground: Colors.grey,
          surface: Colors.grey,
          onSurface: Colors.grey,
          error: Colors.red,
          onError: Colors.white,
        ),
        primaryColor: Colors.yellow,
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
    );
  }
}
