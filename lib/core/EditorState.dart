import 'package:flutter/foundation.dart';
import 'package:fnvim/core/models/DefaultColors.dart';
import 'package:fnvim/core/models/Grid.dart';
import 'package:fnvim/core/models/Highlight.dart';
import 'package:fnvim/core/models/Window.dart';

typedef GridID = int;
typedef WindowID = int;
typedef HighlightID = int;

class EditorState extends ChangeNotifier {
  Map<HighlightID, Highlight> highlights = {};
  Map<GridID, Grid> grids = {};
  GridID active_grid = -1;
  Map<WindowID, Window> windows = {};
  Map<dynamic, dynamic> options = {};
  DefaultColors? defaultColors;

  void flush() {
    notifyListeners();
  }
}
