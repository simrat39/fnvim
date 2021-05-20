import 'package:flutter/material.dart';
import 'package:fnvim/core/models/Grid.dart';
import 'package:fnvim/ui/utils/GridUtils.dart';

class GridRowWidget extends StatefulWidget {
  const GridRowWidget({Key? key, required this.cells}) : super(key: key);

  final List<Cell> cells;

  @override
  State<GridRowWidget> createState() => _GridRowWidgetState();
}

class _GridRowWidgetState extends State<GridRowWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: GridUtils.row_height.toDouble(),
      child: RepaintBoundary(
        child: CustomPaint(
          painter: GridRowPainter(widget.cells),
          isComplex: true,
          willChange: true,
        ),
      ),
    );
  }
}

class GridRowPainter extends CustomPainter {
  final List<Cell> cells;

  GridRowPainter(this.cells);

  @override
  void paint(Canvas canvas, Size size) {
    final textStyle = TextStyle(
      color: Colors.black,
    );

    var x_offset = 0.0;

    for (var cell in cells) {
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

      final yCenter = (size.height - textPainter.height) / 2;
      final xCenter = (size.width - textPainter.width) / 2;

      final offset = Offset(x_offset, yCenter);

      textPainter.paint(canvas, offset);

      x_offset += GridUtils.col_width;
    }
  }

  @override
  bool shouldRepaint(covariant GridRowPainter oldDelegate) {
    return oldDelegate.cells != cells;
  }
}
