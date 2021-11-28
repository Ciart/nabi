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

  LayoutItem? findItem(LayoutItem data, String parentId) {
    if (data.id == parentId) {
      return data;
    }

    if (!(data is LayoutGroup)) {
      return null;
    }

    for (var child in data.children) {
      var result = findItem(child, parentId);

      if (result != null) {
        return result;
      }
    }
  }
}
