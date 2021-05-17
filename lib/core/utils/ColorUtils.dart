import 'package:flutter/widgets.dart';

class ColorUtils {
  static Color from_24_bit_int(int ole) {
    var blue = ole & 255;
    var green = (ole >> 8) & 255;
    var red = (ole >> 16) & 255;

    return Color.fromRGBO(red, blue, green, 1);
  }
}
