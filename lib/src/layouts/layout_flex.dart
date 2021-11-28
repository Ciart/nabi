import 'package:flutter/widgets.dart';
import 'package:nabi/nabi.dart';

@immutable
class LayoutFlex extends LayoutGroup {
  LayoutFlex(
      {String? id,
      int size = 1,
      bool isFlex = true,
      required List<LayoutItem> children,
      required this.direction})
      : super(id: id, size: size, isFlex: isFlex, children: children);

  final Axis direction;
}
