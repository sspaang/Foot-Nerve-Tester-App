import 'package:flutter/material.dart';
import 'package:foot_nerve_tester_app/hive_method.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import '../model/test_result.dart';
import '../boxes.dart';

class TestResultScreen extends StatefulWidget {
  const TestResultScreen({Key? key}) : super(key: key);

  @override
  _TestResultScreenState createState() => _TestResultScreenState();
}

class _TestResultScreenState extends State<TestResultScreen> {
  @override
  void dispose() {
    Hive.box('test_result').close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('ผลการทดสอบ'),
        ),
        body: ValueListenableBuilder<Box<TestResult>>(
          valueListenable: Boxes.getTesingResults().listenable(),
          builder: (context, box, _) {
            final testResults = box.values.toList().cast<TestResult>();
            return buildContent(testResults);
          },
        ));
  }

  Widget buildContent(List<TestResult> testResults) {
    if (testResults.isEmpty) {
      return const Center(
          child: Text(
        'กรุณาทำการทดสอบ',
        style: TextStyle(
          fontSize: 24,
        ),
      ));
    } else {
      return Container(
        margin: const EdgeInsetsDirectional.all(20),
        child: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: testResults.length,
          itemBuilder: (BuildContext context, int index) {
            final testResult = testResults[index];
            return buildTestResult(context, testResult);
          },
        ),
      );
    }
  }

  Widget buildTestResult(BuildContext context, TestResult testResult) {
    final color = testResult.isFeel! ? Colors.green : Colors.red;
    final date = DateFormat.yMMMMd().format(testResult.testDate!);
    final spot = testResult.spot!;
    final resultText = testResult.isFeel! ? "ปกติ" : "มีความเสี่ยง";

    return Card(
      color: Colors.white,
      child: ExpansionTile(
        title: Text(
          spot,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        subtitle: Text(date),
        trailing: Text(
          resultText,
          style: TextStyle(
              color: color, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        children: [buildButton(context, testResult)],
      ),
    );
  }

  Widget buildButton(BuildContext context, TestResult testResult) {
    return Row(
      children: [
        Expanded(
          child: TextButton.icon(
            onPressed: () => deleteTestResult(testResult),
            icon: const Icon(Icons.delete),
            label: const Text('ลบ'),
          ),
        )
      ],
    );
  }
}
