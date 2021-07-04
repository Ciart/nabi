import 'package:flutter/widgets.dart';
import 'package:nabi/nabi.dart';

import 'a_panel.dart';
import 'b_panel.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WidgetsApp(
      title: 'example',
      color: const Color(0xFFFFFFFF),
      debugShowCheckedModeBanner: false,
      builder: (context, int) {
        return Nabi(
          registeredWidgets: {
            'a': Builder(builder: (context) => APanel()),
            'b': Builder(builder: (context) => BPanel())
          },
          config: NabiConfig(
              child: NabiItemConfig(type: NabiItemType.row, children: [
            NabiItemConfig(type: NabiItemType.widget, widgetName: 'a'),
            NabiItemConfig(type: NabiItemType.widget, widgetName: 'b'),
            NabiItemConfig(type: NabiItemType.column, children: [
              NabiItemConfig(type: NabiItemType.widget, widgetName: 'a'),
              NabiItemConfig(type: NabiItemType.widget, widgetName: 'b'),
              NabiItemConfig(type: NabiItemType.widget, widgetName: 'a'),
            ]),
          ])),
        );
      },
    );
  }
}
