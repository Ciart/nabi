import 'package:flutter/widgets.dart';
import 'package:nabi/nabi.dart';
import 'package:nabi/src/extension/extended_iterable.dart';
import 'package:nabi/src/tab.dart';

class NabiStack extends StatefulWidget {
  const NabiStack({Key? key, required this.layout}) : super(key: key);

  final LayoutStack layout;

  @override
  _NabiStackState createState() => _NabiStackState();
}

class _NabiStackState extends State<NabiStack> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.layout,
      builder: (context, child) => Column(
        children: [
          Tab(
              titles: widget.layout.children.map((e) {
                return e is LayoutWidget ? e.title : e.id;
              }).toList(),
              onChange: (index) {
                setState(() {
                  selectedIndex = index;
                });
              }),
          Expanded(
              child: Stack(
            children: widget.layout.children
                .mapIndexed((e, i) => Offstage(
                    offstage: i != selectedIndex,
                    child: Nabi.of(context).convertConfigToWidget(e)))
                .toList(),
          ))
        ],
      ),
    );
  }
}
