import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';

class EvaluateLinkButton extends StatelessWidget {
  const EvaluateLinkButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Link(
      target: LinkTarget.self,
      uri: Uri.parse(
          'https://dmthai.org/index.php/knowledge/for-normal-person/evaluation-form'),
      builder: (context, followLink) {
        return ElevatedButton(
          child: const Text(
            "ทำแบบประเมินความเสี่ยงโรคเบาหวาน",
            style: TextStyle(fontSize: 16),
          ),
          onPressed: followLink,
        );
      },
    );
  }
}
