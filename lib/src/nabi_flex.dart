import 'package:flutter/widgets.dart';
import 'package:nabi/nabi.dart';

class NabiFlex extends StatefulWidget {
  const NabiFlex({Key? key, required this.layout}) : super(key: key);

  final LayoutFlex layout;

  @override
  _NabiFlexState createState() => _NabiFlexState();
}

class _NabiFlexState extends State<NabiFlex> {
  var _sizes = <int>[];
  var _ratios = <double>[];

  @override
  void initState() {
    super.initState();

    _sizes = widget.layout.children.map((e) => e.size).toList();

    var sum = computeSum(_sizes);
    var lastSize = 0;
    _ratios = [];

    for (int i = 0; i < _sizes.length - 1; i++) {
      lastSize += _sizes[i];
      _ratios.add(lastSize / sum);
    }
  }

  @override
  void didUpdateWidget(covariant NabiFlex oldWidget) {
    super.didUpdateWidget(oldWidget);

    _sizes = widget.layout.children.map((e) => e.size).toList();

    var sum = computeSum(_sizes);
    var lastSize = 0;
    _ratios = [];

    for (int i = 0; i < _sizes.length - 1; i++) {
      lastSize += _sizes[i];
      _ratios.add(lastSize / sum);
    }
  }

  @override
  Widget build(BuildContext context) {
    var layout = widget.layout;

    return LayoutBuilder(builder: (context, constraints) {
      return Stack(children: () {
        List<Widget> children = [];

        children.add(Flex(
            direction: layout.direction,
            children: layout.children.map((child) {
              return Flexible(
                  flex: child.size,
                  child: Nabi.of(context).convertConfigToWidget(child));
            }).toList()));

        for (int i = 0; i < layout.children.length - 1; i++) {
          children.add(NabiDivider(
            direction: layout.direction,
            color: const Color(0xff333333),
            position: (layout.direction == Axis.horizontal
                    ? constraints.maxWidth
                    : constraints.maxHeight) *
                _ratios[i],
            onDrag: (details) {
              print(i.toString() + ": " + details.delta.toString());
            },
          ));
        }

        return children;
      }());
    });
  }

  int computeSum(List<int> list) {
    var sum = 0;

    for (var item in list) {
      sum += item;
    }

    return sum;
  }
}
