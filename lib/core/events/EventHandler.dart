import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fnvim/core/EditorState.dart';
import 'package:fnvim/core/events/GlobalEventsHandler.dart';
import 'package:fnvim/core/events/GridEventsHandler.dart';
import 'package:fnvim/core/events/WindowEventsHandler.dart';

class EventHandler extends ChangeNotifier {
  final WindowEventsHandler windowEventsHandler;
  final GridEventsHandler gridEventsHandler;
  final GlobalEventsHandler globalEventsHandler;
  final EditorState state;

  EventHandler(this.state)
      : windowEventsHandler = WindowEventsHandler(state),
        gridEventsHandler = GridEventsHandler(state),
        globalEventsHandler = GlobalEventsHandler(state);

  void handleEvent(List<dynamic> event) {
    String method = event[0];

    switch (method) {
      // ================================
      // Window Events
      // ================================
      case 'win_pos':
        windowEventsHandler.win_pos(event);
        break;
      case 'win_hide':
        windowEventsHandler.win_hide(event);
        break;
      case 'win_close':
        windowEventsHandler.win_close(event);
        break;
      case 'win_viewport':
        windowEventsHandler.win_viewport(event);
        break;
      // ================================
      // Grid Events
      // ================================
      case 'grid_resize':
        gridEventsHandler.grid_resize(event);
        break;
      case 'grid_line':
        gridEventsHandler.grid_line(event);
        break;
      case 'grid_cursor_goto':
        gridEventsHandler.grid_cursor_goto(event);
        break;
      case 'grid_clear':
        gridEventsHandler.grid_clear(event);
        break;
      case 'grid_destroy':
        gridEventsHandler.grid_clear(event);
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
        state.flush();
        break;
      default:
        print(event);
        break;
    }
  }
}
