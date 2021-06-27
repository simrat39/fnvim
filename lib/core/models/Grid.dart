import 'package:equatable/equatable.dart';

class Grid with EquatableMixin {
  final int id;

  int width;
  int height;

  Map<int, List<Cell>> lines = {};
  List<int> updated_lines = [];

  bool is_cursor_visible = true;

  int cursor_row = 0;
  int cursor_col = 0;

  @override
  List<Object?> get props =>
      [id, width, height, lines, is_cursor_visible, cursor_row, cursor_col];

  Grid(this.id, this.width, this.height);

  void clear() {
    lines = {};
  }

  void update_cursor_pos(List<dynamic> args) {
    var row = args[1];
    var col = args[2];
    cursor_col = col;
    cursor_row = row;

    is_cursor_visible = true;
  }

  void hide_cursor() {
    is_cursor_visible = false;
  }

  void flush() {
    updated_lines.clear();
  }

  void add_grid_line(List<dynamic> args) {
    var location = args[1];
    var col = args[2];
    lines[location] = List.from(lines[location] ?? []);

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
      try {
        lines[location]![col] = cell;
      } catch (e) {
        lines[location]!.add(cell);
      }
      col += 1;
    }
  }

  void resize(int width, int height) {
    this.width = width;
    this.height = height;
  }
}

class Cell with EquatableMixin {
  String text;
  int? hl_id;
  int? repeat;

  Cell(this.text, this.hl_id, this.repeat);

  @override
  String toString() {
    return text;
  }

  @override
  List<Object?> get props => [text, hl_id, repeat];
}
