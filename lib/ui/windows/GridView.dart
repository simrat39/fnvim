import 'package:flutter/material.dart';
import 'package:fnvim/core/EditorState.dart';
import 'package:fnvim/core/models/Grid.dart';
import 'package:fnvim/core/models/Window.dart';
import 'package:fnvim/ui/windows/GridRow.dart';

class GridWidget extends StatefulWidget {
  const GridWidget(
      {Key? key,
      required this.grid,
      required this.editorState,
      required this.window})
      : super(key: key);

  final Grid grid;
  final Window window;
  final EditorState editorState;

  @override
  State<GridWidget> createState() => _GridWidgetState();
}

Iterable<E> mapIndexed<E, T>(
    Iterable<T> items, E Function(int index, T item) f) sync* {
  var index = 0;

  for (final item in items) {
    yield f(index, item);
    index = index + 1;
  }
}

class _GridWidgetState extends State<GridWidget> {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      widget.grid.flush();
    });
    return Column(
      children: mapIndexed(
        widget.grid.lines.values,
        (index, e) => GridRowWidget(
          cells: e as List<Cell>,
          line: index,
          editorState: widget.editorState,
          grid: widget.grid,
          window: widget.window,
        ),
      ).toList(),
    );
  }
}
