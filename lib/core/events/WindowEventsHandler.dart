import 'package:fnvim/core/EditorState.dart';
import 'package:fnvim/core/models/Window.dart';
import 'package:fnvim/core/extensions/ForEachArgExtension.dart';

class WindowEventsHandler {
  final EditorState state;

  WindowEventsHandler(this.state);

  int _window_id_from_grid(int grid) {
    var win = -1;
    state.windows.forEach((key, value) {
      if (value.grid == grid) {
        win = key;
      }
    });
    return win;
  }

  /// Set the position and size of the grid in Nvim (i.e. the outer grid
  /// size). If the window was previously hidden, it should now be shown
  /// again.
  void win_pos(List<dynamic> data) {
    data.for_each_arg((arg) {
      var win_id = arg[1].data;
      state.windows[win_id] =
          Window(win_id, arg[0], arg[2], arg[3], arg[4], arg[5], false);
    });
  }

  /// Set the position and size of the grid in Nvim (i.e. the outer grid
  /// size). If the window was previously hidden, it should now be shown
  /// again.
  void win_float_pos(List<dynamic> data) {
    data.for_each_arg((arg) {
      var win_id = arg[1].data;
      state.windows[win_id] =
          Window(win_id, arg[0], arg[2], arg[3], arg[4], arg[5], true);
    });
  }

  /// Close the window.
  void win_close(List<dynamic> data) {
    data.for_each_arg((arg) {
      var grid = arg[0];
      var win = _window_id_from_grid(grid);
      state.windows.remove(win);
    });
  }

  /// Close the window.
  void win_hide(List<dynamic> data) {
    data.for_each_arg((arg) {
      var grid = arg[0];
      var win = _window_id_from_grid(grid);
      state.windows[win]?.hide();
    });
  }

  /// Indicates the range of buffer text displayed in the window, as well
  /// as the cursor position in the buffer. All positions are zero-based.
  /// `botline` is set to one more than the line count of the buffer, if
  /// there are filler lines past the end.
  void win_viewport(List<dynamic> data) {
    data.for_each_arg((arg) {
      var id = arg[1].data;

      var w = state.windows[id];
      w?.topline = arg[2];
      w?.botline = arg[3];
      w?.curline = arg[4];
      w?.curcol = arg[5];
    });
  }
}
