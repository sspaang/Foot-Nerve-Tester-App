import 'package:flutter/material.dart';

class EvaluationScreen extends StatefulWidget {
  const EvaluationScreen({Key? key}) : super(key: key);

  @override
  _EvaluationScreenState createState() => _EvaluationScreenState();
}

class _EvaluationScreenState extends State<EvaluationScreen> {
  int? _groupValue;
  late List<FocusNode> _focusNode;
  int? score;

  @override
  void initState() {
    _focusNode = Iterable<int>.generate(6).map((e) => FocusNode()).toList();
    _focusNode[0].requestFocus();
    score = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("แบบประเมินความเสี่ยงโรคเบาหวานชนิดที่ 2"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          const Text("อายุของคุณ"),
          buildOption("18 - 39 ปี", 0, _focusNode[0]),
          buildOption("40 - 49 ปี", 1, _focusNode[1]),
          buildOption("50 - 59 ปี", 2, _focusNode[2]),
          buildOption("60 ปีขึ้นไป", 3, _focusNode[3]),
          const SizedBox(
            height: 10,
          ),
          const Text("เพศของคุณ"),
          buildOption("หญิง", 0, _focusNode[4]),
          buildOption("ชาย", 1, _focusNode[5]),
          const SizedBox(
            height: 10,
          ),
          const Text("บุคคลใกล้ชิดในครอบครัว (พ่อแม่พี่น้อง) เป็นเบาหวาน"),
          buildOption("ไม่ใช่", 0, _focusNode[6]),
          buildOption("ใช่", 1, _focusNode[7]),
          const SizedBox(
            height: 10,
          ),
          const Text("ประวัติความดันโลหิตสูง"),
          buildOption("ใช่", 0, _focusNode[8]),
          buildOption("ไม่ใช่", 1, _focusNode[9]),
          const SizedBox(
            height: 10,
          ),
          const Text("การออกกำลังกาย"),
          buildOption(
              "ออกกำลังกายสม่ำเสมอ อย่างน้อย 150 นาที (1.30 ชั่วโมง) ต่อวัน",
              0,
              _focusNode[10]),
          buildOption("ไม่ค่อยได้ออกกำลังกาย", 1, _focusNode[11]),
          const SizedBox(
            height: 10,
          ),
          const Text("เพศของคุณ"),
          buildOption("หญิง", 0, _focusNode[0]),
          buildOption("ชาย", 1, _focusNode[1]),
          const SizedBox(
            height: 10,
          ),
          const Text("เพศของคุณ"),
          buildOption("หญิง", 0, _focusNode[0]),
          buildOption("ชาย", 1, _focusNode[1]),
          const SizedBox(
            height: 10,
          ),
          const Text("เพศของคุณ"),
          buildOption("หญิง", 0, _focusNode[0]),
          buildOption("ชาย", 1, _focusNode[1]),
        ],
      ),
    );
  }

  Widget buildOption(
    String option,
    int value,
    FocusNode focusNode,
  ) {
    return ListTile(
      title: Text(option),
      leading: Radio<int>(
        groupValue: _groupValue,
        value: value,
        onChanged: (value) {
          setState(() {
            _groupValue = value;
            score = score! + value!;
          });
        },
        activeColor: Colors.green,
        focusNode: focusNode,
      ),
    );
  }
}
