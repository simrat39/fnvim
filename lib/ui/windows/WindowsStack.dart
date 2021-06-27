import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fnvim/main.dart';

import 'package:fnvim/ui/utils/GridUtils.dart';
import 'package:fnvim/ui/windows/WindowView.dart';

class WindowStack extends StatefulWidget {
  const WindowStack({Key? key}) : super(key: key);

  @override
  State<WindowStack> createState() => _WindowStackState();
}

class _WindowStackState extends State<WindowStack> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        var state = context.read(editorStateProvider);
        var wins_widgs = state.windows.values.map(
          (e) {
            return Positioned(
              top: GridUtils.get_top_offset_from_rows(e.start_row),
              left: GridUtils.get_left_offset_from_cols(e.start_col),
              width: GridUtils.get_width_from_cols(e.width),
              height: GridUtils.get_height_from_rows(e.height),
              child: WindowView(
                window: e,
              ),
            );
          },
        ).toList();
        return Stack(
          children: wins_widgs,
        );
      },
    );
  }
}
