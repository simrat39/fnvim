import 'package:flutter/foundation.dart';
import 'package:fnvim/core/models/DefaultColors.dart';
import 'package:fnvim/core/models/Grid.dart';
import 'package:fnvim/core/models/Highlight.dart';
import 'package:fnvim/core/models/Window.dart';

typedef HighlightID = int;

class EditorState extends ChangeNotifier {
  Map<HighlightID, Highlight> highlights = {};
  Map<int, Grid> grids = {};
  int active_grid = -1;
  Map<int, Window> windows = {};
  Map<dynamic, dynamic> options = {};
  DefaultColors? defaultColors;

  void flush() {
    notifyListeners();
  }
}
