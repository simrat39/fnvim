import 'package:flutter/material.dart';
import 'package:fnvim/core/models/Grid.dart';
import 'package:fnvim/ui/utils/GridUtils.dart';

class CellWidget extends StatefulWidget {
  CellWidget({Key? key, required this.cell}) : super(key: key);

  final Cell cell;

  @override
  State<CellWidget> createState() => _CellWidgetState();
}

class _CellWidgetState extends State<CellWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: GridUtils.col_width.toDouble() * (widget.cell.repeat ?? 1),
      height: GridUtils.row_height.toDouble(),
      child: CustomPaint(
        painter: CellPainter(widget.cell),
        isComplex: true,
      ),
    );
  }
}

class CellPainter extends CustomPainter {
  final Cell cell;

  CellPainter(this.cell);

  @override
  void paint(Canvas canvas, Size size) {
    final textStyle = TextStyle(
      color: Colors.pink,
    );

    final textSpan = TextSpan(
      text: cell.text * (cell.repeat ?? 1),
      style: textStyle,
    );

    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );

    textPainter.layout(
      minWidth: 0,
      maxWidth: size.width,
    );

    final xCenter = (size.width - textPainter.width) / 2;
    final yCenter = (size.height - textPainter.height) / 2;
    final offset = Offset(xCenter, yCenter);

    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
