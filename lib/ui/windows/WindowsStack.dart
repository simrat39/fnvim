import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fnvim/main.dart';
import 'dart:math';

import 'package:fnvim/ui/utils/GridUtils.dart';
import 'package:fnvim/ui/windows/Cell.dart';

class WindowStack extends StatelessWidget {
  const WindowStack({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        var state = watch(editorStateProvider);
        return Stack(
          children: state.windows.values
              .map(
                (e) => Positioned(
                  top: GridUtils.get_top_offset_from_rows(e.start_row),
                  left: GridUtils.get_left_offset_from_cols(e.start_col),
                  child: Visibility(
                    visible: e.isVisible,
                    child: Container(
                      width: GridUtils.get_width_from_cols(e.width),
                      height: GridUtils.get_height_from_rows(e.height),
                      color: Colors
                          .primaries[Random().nextInt(Colors.primaries.length)],
                      child: Builder(
                        builder: (context) {
                          var g = e.get_grid(state);
                          return Stack(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: g!
                                    .getText()
                                    .map((e) => Row(
                                          children: e.characters
                                              .map((e) => Cell(
                                                  text: Text(e),
                                                  width: GridUtils.col_width,
                                                  height: GridUtils.row_height))
                                              .toList(),
                                        ))
                                    .toList(),
                              ),
                              Positioned(
                                top: GridUtils.get_top_offset_from_rows(
                                    g.cursorPos.row),
                                left: GridUtils.get_left_offset_from_cols(
                                    g.cursorPos.column),
                                child: Container(
                                  width: 10,
                                  height: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        );
      },
    );
  }
}
