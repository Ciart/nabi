import 'package:flutter/widgets.dart';

class Nabi extends StatefulWidget {
  const Nabi({Key? key, required this.registeredWidgets, required this.config})
      : super(key: key);

  final Map<String, Widget> registeredWidgets;
  final NabiConfig config;

  @override
  _NabiState createState() => _NabiState();
}

class NabiConfig {
  const NabiConfig({required this.child});

  final NabiItemConfig child;
}

enum NabiItemType { widget, row, column }

class NabiItemConfig {
  NabiItemConfig(
      {required this.type,
      this.widgetName,
      this.children,
      this.size = 1,
      this.isFlex = true});

  final NabiItemType type;
  final String? widgetName;
  final List<NabiItemConfig>? children;

  int size;
  bool isFlex;

  void addChild(NabiItemConfig layoutItemConfig) {
    if (type == NabiItemType.widget) {
      return;
    }

    children?.add(layoutItemConfig);
  }
}

class _NabiState extends State<Nabi> {
  var _config = NabiConfig(child: NabiItemConfig(type: NabiItemType.widget));

  @override
  void initState() {
    super.initState();

    _config = widget.config;
  }

  @override
  Widget build(BuildContext context) {
    return convertConfigToWidget(_config.child);
  }

  Widget convertConfigToWidget(NabiItemConfig config) {
    switch (config.type) {
      case NabiItemType.widget:
        return this.widget.registeredWidgets[config.widgetName] ?? Container();
      case NabiItemType.row:
        if (config.children == null) {
          return Container();
        }
        return Row(
            children: config.children!
                .map((child) => Expanded(child: convertConfigToWidget(child)))
                .toList());
      case NabiItemType.column:
        if (config.children == null) {
          return Container();
        }
        return Column(
            children: config.children!
                .map((child) => Expanded(child: convertConfigToWidget(child)))
                .toList());
    }
  }
}
