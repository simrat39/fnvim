extension ForEachArg on List<dynamic> {
  void for_each_arg(Function(List<dynamic> arg) fn) {
    for (var i = 1; i < length; i++) {
      fn(elementAt(i));
    }
  }
}
