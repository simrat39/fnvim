import 'package:flutter/cupertino.dart';
import 'package:fnvim/core/models/Window.dart';

typedef WindowID = int;

class WindowState extends ChangeNotifier {
  Map<WindowID, Window> windows = {};
}
