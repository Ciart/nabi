import 'package:flutter/foundation.dart';
import 'package:nabi/nabi.dart';

@immutable
class LayoutStack extends LayoutGroup {
  LayoutStack(
      {String? id, int size = 1, bool isFlex = true, required this.children})
      : super(id: id, size: size, isFlex: isFlex, children: children);

  final List<LayoutWidget> children;

  @override
  LayoutStack copyWith(
          {String? id, int? size, bool? isFlex, List<LayoutItem>? children}) =>
      LayoutStack(
          id: id ?? this.id,
          size: size ?? this.size,
          isFlex: isFlex ?? this.isFlex,
          children: children != null
              ? children.whereType<LayoutWidget>().toList()
              : this.children);
}
