import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fnvim/main.dart';
import 'dart:math';

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
                  top: e.start_row.toDouble() * 7.5,
                  left: e.start_col.toDouble() * 7.5,
                  child: Visibility(
                    visible: e.isVisible,
                    child: Container(
                      width: e.width.toDouble() * 7.5,
                      height: e.height.toDouble() * 7.5,
                      color: Colors
                          .primaries[Random().nextInt(Colors.primaries.length)],
                      child: SingleChildScrollView(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: e
                                .get_grid(state)!
                                .getText()
                                .map((e) => Text(e))
                                .toList()),
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
