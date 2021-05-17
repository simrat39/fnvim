import 'package:fnvim/core/models/Highlight.dart';

extension HighlightsExtension on Map<int, Highlight> {
  Highlight? from_name(String name) {
    var index = 0;
    var id = 0;
    var hl;
    for (var i = 0; i < values.length; i++) {
      var el = values.elementAt(i);
      if (el.names.contains(name) && el.id != 1 && el.id > id) {
        id = el.id;
        index = i;
        hl = el;
      }
    }
    return hl;
  }
}
