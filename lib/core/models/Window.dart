import 'package:fnvim/core/EditorState.dart';
import 'package:fnvim/core/models/Grid.dart';

class Window {
  int id;
  int grid;
  int start_row;
  int start_col;
  int width;
  int height;
  bool isFloating = false;
  bool isVisible = true;

  int topline = 0;
  int botline = 0;
  int curline = 0;
  int curcol = 0;

  Window(this.id, this.grid, this.start_row, this.start_col, this.width,
      this.height, this.isFloating);

  void hide() {
    isVisible = false;
  }

  void show() {
    isVisible = true;
  }

  Grid? get_grid(EditorState e) {
    return e.grids[grid];
  }
}
