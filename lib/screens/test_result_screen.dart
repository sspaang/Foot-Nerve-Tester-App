import 'package:flutter/material.dart';

class TestResultScreen extends StatefulWidget {
  const TestResultScreen({Key? key}) : super(key: key);

  @override
  _TestResultScreenState createState() => _TestResultScreenState();
}

class _TestResultScreenState extends State<TestResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ผลลัพธ์การทดสอบ'),
      ),
      body: Container(
        margin: const EdgeInsetsDirectional.all(20),
        child: ListView(
          children: const [
            Center(
              child: Text(
                'ผลลัพธ์การทดสอบ',
                style: TextStyle(fontSize: 24),
              ),
            ),
            ExpansionTile(
              title: Text('การทดสอบครั้งที่ 1 : ไม่มีความเสี่ยง'),
              subtitle: Text('20/12/2021 17:30'),
              children: [
                ListTile(
                  title: Text('จุดที่ 1: รู้สึก'),
                ),
                ListTile(
                  title: Text('จุดที่ 2: รู้สึก'),
                ),
                ListTile(
                  title: Text('จุดที่ 3: รู้สึก'),
                ),
                ListTile(
                  title: Text('จุดที่ 4: รู้สึก'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
