import 'package:nabi/nabi.dart';

class Layout {
  Layout(this.root);

  LayoutItem root;

  LayoutItem? findItem(String targetId, LayoutItem layout) {
    if (targetId == layout.id) {
      return layout;
    }

    if (layout is! LayoutGroup) {
      return null;
    }

    for (var child in layout.children) {
      var result = findItem(targetId, child);

      if (result != null) {
        return result;
      }
    }
  }

  LayoutItem? findItemInRoot(String targetId) {
    return findItem(targetId, root);
  }

  void addChild(String parentId, LayoutWidget layoutWidget) {
    var parent = findItemInRoot(parentId);

    if (parent is LayoutGroup) {
      parent.children.add(layoutWidget);
    }
  }

  void updateChildrenSize(String parentId, List<int> sizes) {
    var parent = findItemInRoot(parentId);

    if (parent is LayoutFlex) {
      var children = parent.children;

      for (int i = 0; i < children.length; i++) {
        children[i] = children[i].copyWith(size: sizes[i]);
      }
    }
  }
}
