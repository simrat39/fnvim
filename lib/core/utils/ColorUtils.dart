import 'package:flutter/widgets.dart';

class ColorUtils {
  static var cache = <int, Color>{};

  static Color? from_24_bit_int(int? ole) {
    if (ole == null) return null;

    var cached = cache[ole];
    if (cached != null) return cached;

    var blue = ole & 255;
    var green = (ole >> 8) & 255;
    var red = (ole >> 16) & 255;

    var color = Color.fromRGBO(red, green, blue, 1);
    cache[ole] = color;

    return color;
  }
}
