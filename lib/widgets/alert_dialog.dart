import 'package:flutter/material.dart';

class AppAlertDialog extends StatelessWidget {
  const AppAlertDialog({
    Key? key,
    required this.title,
    required this.child,
    this.onCancel,
    this.onConfirm,
  }) : super(key: key);

  final Widget? child;
  final String? title;
  final Function? onCancel;
  final Function? onConfirm;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text('ทำการทดสอบ $title'),
          actions: [
            TextButton(
              onPressed: () {
                print('ยกเลิก');
                onCancel;
                Navigator.pop(context);
              },
              child: const Text('ยกเลิก'),
              style: TextButton.styleFrom(primary: Colors.black),
            ),
            TextButton(
              onPressed: () {
                print('confirm');
                onConfirm;
                Navigator.pop(context);
              },
              child: const Text('ตกลง'),
              style: TextButton.styleFrom(primary: Colors.blue),
            ),
          ],
        ),
      ),
      child: child,
    );
  }
}
