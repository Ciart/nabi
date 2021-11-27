import 'package:flutter/foundation.dart';
import 'package:nabi/nabi.dart';

class NabiData extends ChangeNotifier {
  NabiData(this.root);

  NabiItemData root;

  void update() {
    root.children![0].size += 1;
    notifyListeners();
  }

  void addChild(String parentId, String name) {
    var parent = findItem(root, parentId);
    parent?.children?.add(NabiItemData.widget(widgetName: name));
  }

  NabiItemData? findItem(NabiItemData data, String parentId) {
    if (data.id == parentId) {
      return data;
    }

    if (data.children == null) {
      return null;
    }

    for (var child in data.children!) {
      var result = findItem(child, parentId);

      if (result != null) {
        return result;
      }
    }
  }
}
