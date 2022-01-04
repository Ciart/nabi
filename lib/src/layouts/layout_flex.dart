import 'package:flutter/widgets.dart';
import 'package:nabi/nabi.dart';

class LayoutFlex extends LayoutGroup {
  LayoutFlex(
      {String? id,
      int size = 1,
      bool isFlex = true,
      required List<LayoutItem> children,
      required Axis direction})
      : _direction = direction,
        super(id: id, size: size, isFlex: isFlex, children: children);

  Axis _direction;
  Axis get direction => _direction;
  set direction(Axis value) {
    _direction = value;
    notifyListeners();
  }

  @override
  LayoutFlex copyWith(
          {String? id,
          int? size,
          bool? isFlex,
          List<LayoutItem>? children,
          Axis? direction}) =>
      LayoutFlex(
          id: id ?? this.id,
          size: size ?? this.size,
          isFlex: isFlex ?? this.isFlex,
          children: children ?? this.children,
          direction: direction ?? this.direction);
}
