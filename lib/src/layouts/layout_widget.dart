import 'package:flutter/widgets.dart';
import 'package:nabi/nabi.dart';

@immutable
class LayoutWidget extends LayoutItem {
  LayoutWidget(
      {String? id,
      int size = 1,
      bool isFlex = true,
      GlobalKey? key,
      String? title,
      required this.name,
      this.arguments})
      : key = key ?? GlobalKey(),
        title = title ?? name,
        super(id: id, size: size, isFlex: isFlex);

  final GlobalKey key;
  final String title;
  final String name;
  final dynamic arguments;

  @override
  LayoutWidget copyWith(
          {String? id,
          int? size,
          bool? isFlex,
          GlobalKey? key,
          String? title,
          String? name,
          dynamic arguments}) =>
      LayoutWidget(
          id: id ?? this.id,
          size: size ?? this.size,
          isFlex: isFlex ?? this.isFlex,
          key: key ?? this.key,
          title: title ?? this.title,
          name: name ?? this.name,
          arguments: arguments ?? this.arguments);
}
