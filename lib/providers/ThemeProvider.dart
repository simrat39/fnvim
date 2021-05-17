import 'package:flutter/cupertino.dart';

class ThemeProvider extends ChangeNotifier {
  Color? bg;

  void set_bg(Color? bg) {
    this.bg = bg;
    notifyListeners();
  }
}
