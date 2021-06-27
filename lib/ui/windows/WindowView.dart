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
        var editorState = context.read(editorStateProvider);
        var grid = widget.window.get_grid(editorState);

        return Container(
          color: Colors.pink,
          child: Stack(
            children: [
              GridWidget(
                grid: grid!,
                editorState: editorState,
                window: widget.window,
              ),
              Positioned(
                top: GridUtils.get_top_offset_from_rows(grid.cursor_row),
                left: GridUtils.get_left_offset_from_cols(grid.cursor_col),
                child: Cursor(
                  width: GridUtils.col_width,
                  height: GridUtils.row_height,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
