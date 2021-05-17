import 'dart:collection';

import 'package:fnvim/core/models/CursorPosition.dart';

class Grid {
  final int id;

  int width;
  int height;

  SplayTreeMap<CellLocation, List<Cell>> lines =
      SplayTreeMap((a, b) => a.row.compareTo(b.row));

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

  List<String> getText() {
    var ret = <String>[];
    ret.addAll(lines.get_text());
    return ret;
  }

  void add_grid_line(List<dynamic> args) {
    var location = CellLocation(args[1], args[2]);
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
      for (var i = 0; i < repeat; i++) {
        lines[location]?.add(cell);
      }
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
}

extension Collect on Map<CellLocation, List<Cell>> {
  List<String> get_text() {
    var ret = <String>[];
    for (var l in values) {
      var s = '';
      for (var cell in l) {
        s += cell.text;
      }
      ret.add(s);
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
