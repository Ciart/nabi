import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

abstract class LayoutItem extends ChangeNotifier {
  LayoutItem({String? id, int size = 1, bool isFlex = true})
      : id = id ?? Uuid().v4(),
        _size = size,
        _isFlex = isFlex;

  final String id;

  int _size;
  int get size => _size;
  set size(int value) {
    _size = value;
    notifyListeners();
  }

  bool _isFlex;
  bool get isFlex => _isFlex;
  set isFlex(bool value) {
    _isFlex = value;
    notifyListeners();
  }

  LayoutItem copyWith({String? id, int? size, bool? isFlex});
}
