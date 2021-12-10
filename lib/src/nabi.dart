import 'package:flutter/widgets.dart';
import 'package:nabi/nabi.dart';

class Nabi extends StatefulWidget {
  const Nabi({Key? key, required this.registeredWidgets, required this.layout})
      : super(key: key);

  final Map<String, WidgetBuilder> registeredWidgets;
  final Layout layout;

  static NabiState of(BuildContext context) {
    final result = context.findAncestorStateOfType<NabiState>();

    assert(result != null, 'No NabiState found in context');

    return result!;
  }

  @override
  NabiState createState() => NabiState();
}

class NabiWidget extends InheritedWidget {
  NabiWidget({
    Key? key,
    required this.layout,
    required Widget child,
  }) : super(key: key, child: child);

  final LayoutWidget layout;

  static NabiWidget of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<NabiWidget>();

    assert(result != null, 'No NabiWidget found in context');

    return result!;
  }

  @override
  bool updateShouldNotify(NabiWidget oldWidget) => layout != oldWidget.layout;
}

class NabiState extends State<Nabi> {
  Layout get layout => widget.layout;

  Widget convertConfigToWidget(LayoutItem layout) {
    if (layout is LayoutFlex) {
      return NabiFlex(layout: layout);
    } else if (layout is LayoutStack) {
      return NabiStack(layout: layout);
    } else if (layout is LayoutWidget) {
      var builder = widget.registeredWidgets[layout.name];

      assert(
          builder != null, '\'$layout.name\' is not in the registeredWidgets.');

      return NabiWidget(
          layout: layout, child: Builder(key: layout.key, builder: builder!));
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return convertConfigToWidget(widget.layout.root);
  }
}
