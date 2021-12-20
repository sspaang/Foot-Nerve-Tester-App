import 'package:flutter/material.dart';

class CircleImage extends StatelessWidget {
  const CircleImage({Key? key, required this.image}) : super(key: key);

  final AssetImage image;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 50,
      backgroundColor: Colors.yellow,
      child: CircleAvatar(
        radius: 45,
        backgroundColor: Colors.white,
        foregroundImage: image,
      ),
    );
  }
}
