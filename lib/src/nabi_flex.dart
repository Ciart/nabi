import 'package:flutter/widgets.dart';
import 'package:nabi/nabi.dart';
import 'package:nabi/src/extension/extended_iterable.dart';

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

    for (int i = 0; i < _sizes.length; i++) {
      _ratios.add(_sizes[i] / sum);
    }
  }

  @override
  void didUpdateWidget(covariant NabiFlex oldWidget) {
    super.didUpdateWidget(oldWidget);

    _sizes = widget.layout.children.map((e) => e.size).toList();

    var sum = computeSum(_sizes);
    var lastSize = 0;
    _ratios = [];

    for (int i = 0; i < _sizes.length; i++) {
      _ratios.add(_sizes[i] / sum);
    }
  }

  @override
  Widget build(BuildContext context) {
    var layout = widget.layout;

    return LayoutBuilder(builder: (context, constraints) {
      var maxSize = layout.direction == Axis.horizontal
          ? constraints.maxWidth
          : constraints.maxHeight;
      var sizes = _ratios.map((ratio) => maxSize * ratio).toList();

      return Stack(children: () {
        List<Widget> children = [];

        children.add(Flex(
            direction: layout.direction,
            children: layout.children.mapIndexed((child, i) {
              if (child.isFlex) {
                return Flexible(
                    flex: sizes[i].toInt(),
                    child: Nabi.of(context).convertConfigToWidget(child));
              } else {
                return SizedBox(
                    width: layout.direction == Axis.horizontal
                        ? child.size.toDouble()
                        : null,
                    height: layout.direction == Axis.vertical
                        ? child.size.toDouble()
                        : null,
                    child: Nabi.of(context).convertConfigToWidget(child));
              }
            }).toList()));

        var position = 0.0;

        for (int i = 0; i < sizes.length - 1; i++) {
          position += sizes[i];

          children.add(NabiDivider(
            direction: layout.direction,
            color: const Color(0xff333333),
            position: position,
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
