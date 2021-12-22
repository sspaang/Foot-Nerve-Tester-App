import 'package:flutter/material.dart';
import '../screens/test_result_screen.dart';

class ResultButton extends StatelessWidget {
  const ResultButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const TestResultScreen())),
      child: const Text(
        'ดูผลการทดสอบ',
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}
