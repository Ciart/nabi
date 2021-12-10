import 'package:flutter/widgets.dart';
import 'package:nabi/nabi.dart';

import 'a_panel.dart';
import 'b_panel.dart';
import 'counter.dart';

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
            'a': (context) => APanel(),
            'b': (context) => BPanel(),
            'counter': (context) => Counter()
          },
          layout: Layout(LayoutFlex(direction: Axis.horizontal, children: [
            LayoutWidget(name: 'a'),
            LayoutStack(children: [
              LayoutWidget(name: 'b', arguments: BArguments(Color(0xff453454))),
              LayoutWidget(name: 'a'),
              LayoutWidget(name: 'counter'),
            ]),
            LayoutWidget(name: 'b', arguments: BArguments(Color(0xff382a00))),
            LayoutFlex(direction: Axis.vertical,
                //size: 200,
                //isFlex: false,
                children: [
                  LayoutWidget(name: 'counter'),
                  LayoutWidget(name: 'a'),
                ]),
          ])),
        );
      },
    );
  }
}
