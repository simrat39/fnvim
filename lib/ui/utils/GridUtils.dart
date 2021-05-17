import 'package:flutter/widgets.dart';

class GridUtils {
  static var row_height = 17;
  static var col_width = 13;

  static Size get_grid_dimensions(Size screen) {
    var rows = (screen.height / row_height).floor() + 1;
    var cols = (screen.width / col_width).floor() + 1;
    return Size(cols.toDouble(), rows.toDouble());
  }

  static double get_height_from_rows(int rows) {
    return ((rows * row_height) + row_height).toDouble();
  }

  static double get_width_from_cols(int cols) {
    return ((cols * col_width) + col_width).toDouble();
  }

  static double get_top_offset_from_rows(int rows) {
    return (rows * row_height).toDouble();
  }

  static double get_left_offset_from_cols(int cols) {
    return (cols * col_width).toDouble();
  }
}
