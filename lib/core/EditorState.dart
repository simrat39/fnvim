import 'package:flutter/foundation.dart';
import 'package:fnvim/core/models/DefaultColors.dart';
import 'package:fnvim/core/models/Highlight.dart';

typedef HighlightID = int;

class EditorState extends ChangeNotifier {
  Map<HighlightID, Highlight> highlights = {};
  Map<dynamic, dynamic> options = {};
  DefaultColors? defaultColors;

  void flush() {
    notifyListeners();
  }
}
