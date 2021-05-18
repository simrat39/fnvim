import 'package:flutter/material.dart';

class Cell extends StatelessWidget {
  Cell(
      {Key? key, required this.text, required this.width, required this.height})
      : super(key: key);

  Text text;
  int width;
  int height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width.toDouble(),
      height: height.toDouble(),
      child: text,
    );
  }
}
