import 'package:nabi/nabi.dart';

abstract class LayoutGroup extends LayoutItem {
  LayoutGroup(
      {String? id,
      int size = 1,
      bool isFlex = true,
      required List<LayoutItem> children})
      : _children = children,
        super(id: id, size: size, isFlex: isFlex);

  List<LayoutItem> _children;
  List<LayoutItem> get children => _children;

  @override
  LayoutItem copyWith(
      {String? id, int? size, bool? isFlex, List<LayoutItem>? children});

  void addChild(LayoutItem layout) {
    _children.add(layout);
    notifyListeners();
  }

  void removeChild(LayoutItem layout) {
    _children.remove(layout);
    notifyListeners();
  }
}
