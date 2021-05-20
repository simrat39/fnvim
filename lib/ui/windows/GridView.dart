import 'package:flutter/material.dart';
import 'package:fnvim/core/models/Grid.dart';
import 'package:fnvim/ui/windows/GridRow.dart';

class GridWidget extends StatefulWidget {
  const GridWidget({Key? key, required this.grid}) : super(key: key);

  final Grid grid;

  @override
  State<GridWidget> createState() => _GridWidgetState();
}

class _GridWidgetState extends State<GridWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.grid.lines.values
          .map(
            (e) => GridRowWidget(
              cells: e,
            ),
          )
          .toList(),
    );
  }
}
