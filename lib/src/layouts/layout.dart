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

  LayoutGroup? findParent(String childId, LayoutItem layout) {
    if (layout is! LayoutGroup) {
      return null;
    }

    for (var child in layout.children) {
      if (child.id == childId) {
        return layout;
      }

      var result = findParent(childId, child);

      if (result != null) {
        return result;
      }
    }
  }

  LayoutGroup? findParentInRoot(String childId) {
    return findParent(childId, root);
  }

  void addChild(String parentId, LayoutWidget layoutWidget) {
    var parent = findItemInRoot(parentId);

    if (parent is LayoutGroup) {
      var parentOfParent = findParentInRoot(parentId);

      if (parentOfParent == null) {
        return;
      }

      for (int i = 0; i < parentOfParent.children.length; i++) {
        if (parentOfParent.children[i].id == parentId) {
          parentOfParent.children[i] =
              parent.copyWith(children: [...parent.children, layoutWidget]);
        }
      }
    }
  }

  void updateChildrenSize(String parentId, List<int> sizes) {
    var parent = findItemInRoot(parentId);

    if (parent is LayoutFlex) {
      var children = parent.children;

      for (int i = 0; i < children.length; i++) {
        children[i].size = sizes[i];
      }
    }
  }
}
