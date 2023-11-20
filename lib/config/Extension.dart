import 'package:intl/intl.dart';

extension uniquelList on List {
  List unique() {
    return this.toSet().toList();
  }
}

