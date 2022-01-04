import 'package:flutter/widgets.dart';
import 'package:nabi/nabi.dart';

class LayoutWidget extends LayoutItem {
  LayoutWidget({
    String? id,
    int size = 1,
    bool isFlex = true,
    GlobalKey? key,
    required this.name,
    String? title,
    dynamic arguments,
  })  : key = key ?? GlobalKey(),
        _title = title ?? name,
        _arguments = arguments,
        super(id: id, size: size, isFlex: isFlex);

  final GlobalKey key;
  final String name;

  String _title;
  String get title => _title;
  set title(String value) {
    _title = value;
    notifyListeners();
  }

  dynamic _arguments;
  dynamic get arguments => _arguments;
  set arguments(value) {
    _arguments = value;
    notifyListeners();
  }

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
