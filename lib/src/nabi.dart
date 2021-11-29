import 'package:flutter/widgets.dart';
import 'package:nabi/nabi.dart';

class Nabi extends StatefulWidget {
  const Nabi({Key? key, required this.registeredWidgets, required this.layout})
      : super(key: key);

  final Map<String, Widget> registeredWidgets;
  final Layout layout;

  static NabiState of(BuildContext context) {
    final result = context.findAncestorStateOfType<NabiState>();

    assert(result != null, 'No NabiState found in context');

    return result!;
  }

  @override
  NabiState createState() => NabiState();
}

class NabiState extends State<Nabi> {
  Layout get layout => widget.layout;

  Widget convertConfigToWidget(LayoutItem layout) {
    if (layout is LayoutFlex) {
      return NabiFlex(layout: layout);
    } else if (layout is LayoutWidget) {
      return Container(
          key: layout.key, child: widget.registeredWidgets[layout.name]);
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return convertConfigToWidget(widget.layout.root);
  }
}
