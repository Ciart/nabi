import 'package:flutter/widgets.dart';
import 'package:nabi/nabi.dart';

class Nabi extends StatefulWidget {
  const Nabi({Key? key, required this.registeredWidgets, required this.data})
      : super(key: key);

  final Map<String, Widget> registeredWidgets;
  final NabiData data;

  static NabiState of(BuildContext context) {
    final result = context.findAncestorStateOfType<NabiState>();

    assert(result != null, 'No NabiState found in context');

    return result!;
  }

  @override
  NabiState createState() => NabiState();
}

class NabiState extends State<Nabi> {
  @override
  void initState() {
    super.initState();
  }

  Widget convertConfigToWidget(NabiItemData config) {
    switch (config.type) {
      case NabiItemType.widget:
        return widget.registeredWidgets[config.widgetName] ?? Container();
      case NabiItemType.row:
        if (config.children == null) {
          return Container();
        }
        return NabiFlex(direction: Axis.horizontal, data: config);
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

  @override
  Widget build(BuildContext context) {
    return convertConfigToWidget(widget.data.root);
  }
}
