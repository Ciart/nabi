import 'package:nabi/nabi.dart';

class Layout {
  Layout(this.root);

  LayoutItem root;

  LayoutItem? findItem(LayoutItem layout, String parentId) {
    if (layout.id == parentId) {
      return layout;
    }

    if (!(layout is LayoutGroup)) {
      return null;
    }

    for (var child in layout.children) {
      var result = findItem(child, parentId);

      if (result != null) {
        return result;
      }
    }
  }

  void addChild(String parentId, LayoutWidget layoutWidget) {
    var parent = findItem(root, parentId);

    if (parent is LayoutGroup) {
      parent.children.add(layoutWidget);
    }
  }

  void updateChildrenSize(String parentId, List<int> sizes) {
    var parent = findItem(root, parentId);

    if (parent is LayoutFlex) {
      var children = parent.children;

      for (int i = 0; i < children.length; i++) {
        children[i] = children[i].copyWith(size: sizes[i]);
      }
    }
  }
}
