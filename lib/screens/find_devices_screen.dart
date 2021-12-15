import 'package:flutter/material.dart';

class FindDeviceScreen extends StatefulWidget {
  const FindDeviceScreen({Key? key}) : super(key: key);

  @override
  _FindDeviceScreenState createState() => _FindDeviceScreenState();
}

class _FindDeviceScreenState extends State<FindDeviceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Find Device"),
      ),
      body: Container(),
    );
  }
}
