import 'package:flutter/foundation.dart';
import 'package:nabi/nabi.dart';

@immutable
abstract class LayoutGroup extends LayoutItem {
  LayoutGroup(
      {String? id, int size = 1, bool isFlex = true, required this.children})
      : super(id: id, size: size, isFlex: isFlex);

  final List<LayoutItem> children;

  void addChild(LayoutItem item) {
    children.add(item);
  }
}
