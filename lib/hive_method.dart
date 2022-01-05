import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import './model/test_result.dart';
import './boxes.dart';

Future addTestResult(String spot, bool isFeel) async {
  final testResult = TestResult()
    ..spot = spot
    ..isFeel = isFeel
    ..testDate = DateTime.now();

  final box = Boxes.getTesingResults();
  box.add(testResult);
  print("add test result");
}

void deleteTestResult(TestResult testResult) {
  testResult.delete();
  print("delete test result");
}
