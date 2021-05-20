import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fnvim/core/EditorState.dart';
import 'package:fnvim/core/events/GlobalEventsHandler.dart';
import 'package:fnvim/core/events/GridEventsHandler.dart';
import 'package:fnvim/core/events/WindowEventsHandler.dart';
import 'package:fnvim/core/state/GridState.dart';
import 'package:fnvim/core/state/WindowState.dart';

class EventHandler extends ChangeNotifier {
  final WindowEventsHandler windowEventsHandler;
  final GridEventsHandler gridEventsHandler;
  final GlobalEventsHandler globalEventsHandler;
  final EditorState state;
  final WindowState winState;
  final GridState gridState;
  final ChangeNotifier gridCursorState;

  bool redraw_win = false;
  bool redraw_grid = false;
  bool redraw_cursor = false;

  EventHandler(this.state, this.winState, this.gridState, this.gridCursorState)
      : windowEventsHandler = WindowEventsHandler(winState),
        gridEventsHandler = GridEventsHandler(gridState),
        globalEventsHandler = GlobalEventsHandler(state);

  Future handleEvent(List<dynamic> event) async {
    String method = event[0];

    switch (method) {
      // ================================
      // Window Events
      // ================================
      case 'win_pos':
        windowEventsHandler.win_pos(event);
        redraw_win = true;
        break;
      case 'win_hide':
        windowEventsHandler.win_hide(event);
        redraw_win = true;
        break;
      case 'win_close':
        windowEventsHandler.win_close(event);
        redraw_win = true;
        break;
      case 'win_viewport':
        windowEventsHandler.win_viewport(event);
        redraw_win = true;
        break;
      // ================================
      // Grid Events
      // ================================
      case 'grid_resize':
        gridEventsHandler.grid_resize(event);
        redraw_grid = true;
        break;
      case 'grid_line':
        gridEventsHandler.grid_line(event);
        redraw_grid = true;
        break;
      case 'grid_cursor_goto':
        gridEventsHandler.grid_cursor_goto(event);
        redraw_cursor = true;
        break;
      case 'grid_clear':
        gridEventsHandler.grid_clear(event);
        redraw_grid = true;
        break;
      case 'grid_destroy':
        gridEventsHandler.grid_clear(event);
        redraw_grid = true;
        break;
      // ================================
      // Global / Other Events
      // ================================
      case 'default_colors_set':
        globalEventsHandler.default_colors_set(event);
        break;
      case 'hl_attr_define':
        globalEventsHandler.hl_attr_define(event);
        break;
      case 'hl_group_set':
        globalEventsHandler.hl_group_set(event);
        break;
      case 'option_set':
        globalEventsHandler.option_set(event);
        break;
      case 'flush':
        if (redraw_win) {
          winState.notifyListeners();
        }
        if (redraw_grid) {
          gridState.notifyListeners();
        }
        if (redraw_cursor) {
          gridCursorState.notifyListeners();
        }
        redraw_grid = false;
        redraw_win = false;
        redraw_grid = false;
        // state.flush();
        break;
      default:
        print(event);
        break;
    }
  }
}
