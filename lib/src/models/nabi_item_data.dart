import 'package:uuid/uuid.dart';

enum NabiItemType { widget, row, column }

class NabiItemData {
  NabiItemData(
      {required this.type,
      this.widgetName,
      this.children,
      this.size = 1,
      this.isFlex = true});

  NabiItemData.widget(
      {required String widgetName, int size = 1, bool isFlex = true})
      : this(
            type: NabiItemType.widget,
            widgetName: widgetName,
            size: size,
            isFlex: isFlex);

  final NabiItemType type;
  final String? widgetName;
  final List<NabiItemData>? children;

  int size;
  bool isFlex;

  final _id = Uuid().v4();
  get id => _id;

  void addChild(NabiItemData itemData) {
    if (type == NabiItemType.widget) {
      return;
    }

    children?.add(itemData);
  }
}
