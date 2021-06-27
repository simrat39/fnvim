import 'package:flutter/material.dart';

class Cursor extends StatefulWidget {
  const Cursor({Key? key, required this.width, required this.height})
      : super(key: key);

  final int width;
  final int height;

  @override
  State<Cursor> createState() => _CursorState();
}

class _CursorState extends State<Cursor> with SingleTickerProviderStateMixin {
  // late AnimationController animationController;
  // late Animation opacity;

  @override
  void initState() {
    // animationController =
    //     AnimationController(vsync: this, duration: Duration(seconds: 2));
    // animationController.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    // animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // return AnimatedBuilder(
    //   animation: animationController,
    //   builder: (context, child) {
    return Container(
      width: widget.width.toDouble(),
      height: widget.height.toDouble(),
      color: Colors.red, //withOpacity(animationController.value),
    );
    // },
    // );
  }
}
