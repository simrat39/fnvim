import 'package:fnvim/core/models/CursorPosition.dart';

typedef GridRow = int;

class Grid {
  final int id;

  int width;
  int height;

  Map<GridRow, List<Cell>> lines = {};

  bool is_cursor_visible = true;
  CursorPosition cursorPos = CursorPosition(0, 0);

  Grid(this.id, this.width, this.height);

  void clear() {
    lines.clear();
  }

  void update_cursor_pos(List<dynamic> args) {
    var row = args[1];
    var col = args[2];
    is_cursor_visible = true;
    cursorPos.update(row, col);
  }

  void hide_cursor() {
    is_cursor_visible = false;
  }

  List<List<Cell>> getText() {
    return [];
    // return lines.get_text();
  }

  void add_grid_line(List<dynamic> args) {
    var location = args[1];
    lines[location] = [];
    for (var k = 0; k < args[3].length; k++) {
      int? hl_id;
      var repeat = 1;
      var raw_cell = args[3][k];
      if (raw_cell.length == 2) {
        hl_id = raw_cell[1];
      } else if (raw_cell.length == 3) {
        hl_id = raw_cell[1];
        repeat = raw_cell[2];
      }
      var cell = Cell(raw_cell[0], hl_id, repeat);
      lines[location]?.add(cell);
    }
  }

  void resize(int width, int height) {
    this.width = width;
    this.height = height;
  }

  static Grid? gridFromId(List<Grid> grids, int id) {
    for (var grid in grids) {
      if (grid.id == id) {
        return grid;
      }
    }
  }
}

class Cell {
  String text;
  int? hl_id;
  int? repeat;

  Cell(this.text, this.hl_id, this.repeat);

  @override
  String toString() {
    return text;
  }

  @override
  int get hashCode => text.hashCode;

  @override
  bool operator ==(o) => o is Cell && text == o.text;
}

extension Collect on Map<GridRow, List<Cell>> {
  List<List<Cell>> get_text() {
    var ret = <List<Cell>>[];
    for (var l in values) {
      var oret = <Cell>[];
      for (var cell in l) {
        oret.add(cell);
      }
      ret.add(oret);
    }
    return ret;
  }
}

class CellLocation {
  int row;
  int col_start;

  CellLocation(this.row, this.col_start);

  @override
  int get hashCode => row * col_start;

  @override
  bool operator ==(o) =>
      o is CellLocation && row == o.row && col_start == o.col_start;
}
