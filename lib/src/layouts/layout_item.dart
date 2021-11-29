import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

@immutable
abstract class LayoutItem {
  LayoutItem({String? id, this.size = 1, this.isFlex = true})
      : id = id ?? Uuid().v4();

  final String id;
  final int size;
  final bool isFlex;

  LayoutItem copyWith({String? id, int? size, bool? isFlex});
}
