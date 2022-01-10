import 'package:flutter_easyloading/flutter_easyloading.dart';
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

void clearTestResult() async {
  final box = Boxes.getTesingResults();
  _showWorkingDialog('กำลังลบประวัติการทดสอบ');
  await box.clear();
  _hideWorkingDialog();
  print("clear test result");
}

_showWorkingDialog(String text) {
  EasyLoading.show(
    status: text,
    maskType: EasyLoadingMaskType.black,
    dismissOnTap: false,
  );
}

_hideWorkingDialog() {
  if (EasyLoading.isShow) EasyLoading.dismiss();
}
