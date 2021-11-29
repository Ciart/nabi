import 'package:flutter/foundation.dart';
import 'package:nabi/nabi.dart';

class Layout extends ChangeNotifier {
  Layout(this.root);

  LayoutItem root;

  void addChild(String parentId, String name, String? title) {
    var parent = findItem(root, parentId);

    if (parent is LayoutGroup) {
      parent.children.add(LayoutWidget(name: name));
    }
  }

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
}
