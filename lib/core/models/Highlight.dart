class Highlight {
  final int id;
  final Map<dynamic, dynamic>? rgb_attr;
  final Map<dynamic, dynamic>? cterm_attr;
  final List<dynamic>? info;
  List<String> names = [];

  Highlight(this.id, this.rgb_attr, this.cterm_attr, this.info);

  @override
  String toString() {
    return 'Highlight(id: $id, names: $names, rgb_attr: $rgb_attr, cterm_attr: $cterm_attr, info: $info)\n';
  }

  void addName(String name) {
    if (!names.contains(name)) {
      names.add(name);
    }
  }
}
