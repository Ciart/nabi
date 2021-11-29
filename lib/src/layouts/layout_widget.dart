import 'package:flutter/widgets.dart';
import 'package:nabi/nabi.dart';

@immutable
class LayoutWidget extends LayoutItem {
  LayoutWidget(
      {String? id,
      int size = 1,
      bool isFlex = true,
      String? title,
      required this.name})
      : title = title ?? name,
        super(id: id, size: size, isFlex: isFlex);

  final GlobalKey key = GlobalKey();
  final String title;
  final String name;

  @override
  LayoutWidget copyWith(
          {String? id, int? size, bool? isFlex, String? title, String? name}) =>
      LayoutWidget(
          id: id ?? this.id,
          size: size ?? this.size,
          isFlex: isFlex ?? this.isFlex,
          title: title ?? this.title,
          name: name ?? this.name);
}
