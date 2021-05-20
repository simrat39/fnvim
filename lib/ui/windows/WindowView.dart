import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fnvim/core/models/Window.dart';
import 'package:fnvim/main.dart';
import 'package:fnvim/ui/utils/GridUtils.dart';
import 'package:fnvim/ui/windows/Cursor.dart';
import 'package:fnvim/ui/windows/GridView.dart';

class WindowView extends StatefulWidget {
  const WindowView({Key? key, required this.window}) : super(key: key);

  final Window window;

  @override
  State<WindowView> createState() => _WindowViewState();
}

class _WindowViewState extends State<WindowView> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        var gridState = watch(gridStateProvider);
        var grid = widget.window.get_grid(gridState);

        return Stack(
          children: [
            GridWidget(grid: grid!),
            Positioned(
              top: GridUtils.get_top_offset_from_rows(grid.cursorPos.row),
              left: GridUtils.get_left_offset_from_cols(grid.cursorPos.column),
              // duration: Duration(milliseconds: 70),
              child: Consumer(
                builder: (context, watch, child) {
                  watch(gridCursorStateProvider);
                  return child!;
                },
                child: Cursor(
                  width: GridUtils.col_width,
                  height: GridUtils.row_height,
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
