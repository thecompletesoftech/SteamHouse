
extension uniquelList on List {
  List unique() {
    return this.toSet().toList();
  }
}

