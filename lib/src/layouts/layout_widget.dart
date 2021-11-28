import 'package:flutter/foundation.dart';
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

  final String name;
  final String title;
}
