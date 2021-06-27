import 'package:fnvim/core/EditorState.dart';
import 'package:fnvim/core/extensions/ForEachArgExtension.dart';
import 'package:fnvim/core/models/Grid.dart';

class GridEventsHandler {
  final EditorState state;

  GridEventsHandler(this.state);

  /// Resize a [Grid]. If [Grid] wasn't seen by the client before, a new grid is
  /// being created with this size.
  void grid_resize(List<dynamic> data) {
    data.for_each_arg((arg) {
      var grid_id = arg[0] as int;
      var width = arg[1] as int;
      var height = arg[2] as int;

      var grid = state.grids[grid_id];
      if (grid != null) {
        grid.resize(width, height);
      } else {
        state.grids[grid_id] = Grid(grid_id, width, height);
      }
    });
  }

  /// Redraw a continuous part of a `row` on a [Grid], starting at the column
  /// `col_start`. `cells` is an array of arrays each with 1 to 3 items:
  /// `[text(, hl_id, repeat)]` . `text` is the UTF-8 text that should be put in
  /// a cell, with the highlight `hl_id` defined by a previous `hl_attr_define`
  /// call.  If `hl_id` is not present the most recently seen `hl_id` in
  /// the same call should be used (it is always sent for the first
  /// cell in the event). If `repeat` is present, the cell should be
  /// repeated `repeat` times (including the first time), otherwise just
  /// once.
  ///
  /// The right cell of a double-width char will be represented as the empty
  /// string. Double-width chars never use `repeat`.
  ///
  /// If the array of cell changes doesn't reach to the end of the line, the
  /// rest should remain unchanged. A whitespace char, repeated
  /// enough to cover the remaining line, will be sent when the rest of the
  /// line should be cleared.
  void grid_line(List<dynamic> data) {
    data.for_each_arg((arg) {
      var grid = state.grids[arg[0] as int];
      if (arg[0] != 1) {
        print(data);
      }
      grid?.add_grid_line(arg);
    });
  }

  /// Makes [Grid] the current grid and `row, column` the cursor position on this
  /// grid.  This event will be sent at most once in a `redraw` batch and
  /// indicates the visible cursor position.
  void grid_cursor_goto(List<dynamic> data) {
    data.for_each_arg((arg) {
      var grid = state.grids[arg[0] as int];
      grid?.update_cursor_pos(arg);
      state.active_grid = grid?.id ?? -1;
    });
  }

  /// Clear a [Grid].
  void grid_clear(List<dynamic> data) {
    data.for_each_arg((arg) {
      var grid = state.grids[arg[0] as int];
      grid?.clear();
    });
  }

  /// [Grid] will not be used anymore and the UI can free any data associated
  /// with it.
  void grid_destroy(List<dynamic> data) {
    data.for_each_arg((arg) {
      var grid_id = arg[0] as int;
      state.grids.remove(grid_id);
    });
  }
}
