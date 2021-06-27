import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:fnvim/core/EditorState.dart';
import 'package:fnvim/core/models/Grid.dart';
import 'package:fnvim/core/models/Highlight.dart';
import 'package:fnvim/core/models/Window.dart';
import 'package:fnvim/core/utils/ColorUtils.dart';
import 'package:fnvim/ui/utils/GridUtils.dart';
import 'package:flutter/foundation.dart';

class GridRowWidget extends StatefulWidget {
  const GridRowWidget(
      {Key? key,
      required this.cells,
      required this.line,
      required this.grid,
      required this.editorState,
      required this.window})
      : super(key: key);

  final List<Cell> cells;
  final int line;
  final Grid grid;
  final EditorState editorState;
  final Window window;

  @override
  State<GridRowWidget> createState() => _GridRowWidgetState();
}

class _GridRowWidgetState extends State<GridRowWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: GridUtils.get_width_from_cols(widget.window.width),
      height: GridUtils.row_height.toDouble(),
      child: RepaintBoundary(
        child: CustomPaint(
          painter: GridRowPainter(
            widget.cells,
            widget.editorState,
            widget.line,
            widget.grid,
          ),
          isComplex: true,
          willChange: true,
        ),
      ),
    );
  }
}

class GridRowPainter extends CustomPainter {
  final List<Cell> cells;
  final EditorState editorState;
  final int line;
  final Grid grid;

  GridRowPainter(this.cells, this.editorState, this.line, this.grid);

  @override
  void paint(Canvas canvas, Size size) {
    var x_offset = 0.0;

    Highlight? hl;
    Color? col;
    Color? bg_col;

    for (var cell in cells) {
      var new_hl = editorState.highlights[cell.hl_id];
      var repeat = cell.repeat ?? 1;

      if (new_hl != null) {
        hl = new_hl;
        col = ColorUtils.from_24_bit_int(hl.rgb_attr?['foreground']) ??
            Colors.white;
        bg_col = ColorUtils.from_24_bit_int(hl.rgb_attr?['background']) ??
            Colors.black;
      }

      final textStyle = TextStyle(
        color: col,
      );

      final textSpan = TextSpan(
        text: cell.text,
        style: textStyle,
        mouseCursor: SystemMouseCursors.wait,
      );

      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );

      textPainter.layout(
        maxWidth: GridUtils.col_width.toDouble(),
        minWidth: GridUtils.col_width.toDouble(),
      );

      if (x_offset < size.width) {
        canvas.drawRect(
            Rect.fromLTWH(x_offset, 0, GridUtils.col_width.toDouble() * repeat,
                GridUtils.row_height.toDouble()),
            Paint()..color = bg_col ?? Colors.black);

        for (var i = 0; i < repeat; i++) {
          final offset = Offset(x_offset - textPainter.width, 0);

          textPainter.paint(canvas, offset);

          x_offset += GridUtils.col_width;
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant GridRowPainter oldDelegate) {
    return !DeepCollectionEquality.unordered().equals(cells, oldDelegate.cells);
  }
}
