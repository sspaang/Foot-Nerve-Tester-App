import 'package:hive/hive.dart';
import './model/test_result.dart';

class Boxes {
  static Box<TestResult> getTesingResults() =>
      Hive.box<TestResult>('test_result');
}
