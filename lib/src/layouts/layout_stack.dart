import 'package:nabi/nabi.dart';

class LayoutStack extends LayoutGroup {
  LayoutStack({
    String? id,
    int size = 1,
    bool isFlex = true,
    required List<LayoutItem> children,
  }) : super(id: id, size: size, isFlex: isFlex, children: children);

  @override
  LayoutStack copyWith(
          {String? id, int? size, bool? isFlex, List<LayoutItem>? children}) =>
      LayoutStack(
        id: id ?? this.id,
        size: size ?? this.size,
        isFlex: isFlex ?? this.isFlex,
        children: children ?? this.children,
      );
}
