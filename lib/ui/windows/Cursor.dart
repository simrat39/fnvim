import 'package:flutter/material.dart';

class Cursor extends StatelessWidget {
  const Cursor({Key? key, required this.width, required this.height})
      : super(key: key);

  final int width;
  final int height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width.toDouble(),
      height: height.toDouble(),
      color: Colors.red,
    );
  }
}
