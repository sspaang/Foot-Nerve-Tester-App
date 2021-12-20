import 'package:flutter/material.dart';

class ResultButton extends StatelessWidget {
  const ResultButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => print('ดูผลการทดสอบ'),
      child: const Text('ดูผลการทดสอบ'),
    );
  }
}
