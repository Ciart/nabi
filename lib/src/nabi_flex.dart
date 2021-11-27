import 'package:flutter/widgets.dart';
import 'package:nabi/nabi.dart';

class NabiFlex extends StatefulWidget {
  const NabiFlex({Key? key, required this.direction, required this.data})
      : super(key: key);

  final Axis direction;
  final NabiItemData data;

  @override
  _NabiFlexState createState() => _NabiFlexState();
}

class _NabiFlexState extends State<NabiFlex> {
  var _sizes = <int>[];
  var _ratios = <double>[];

  @override
  void initState() {
    super.initState();

    if (widget.data.children == null) {
      return;
    }

    _sizes = widget.data.children!.map((e) => e.size).toList();

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

    if (widget.data.children == null) {
      return;
    }

    _sizes = widget.data.children!.map((e) => e.size).toList();

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
    var childrenData = widget.data.children ?? [];

    return LayoutBuilder(builder: (context, constraints) {
      return Stack(children: () {
        List<Widget> children = [];

        children.add(Flex(
            direction: widget.direction,
            children: childrenData.map((child) {
              return Flexible(
                  flex: child.size,
                  child: Nabi.of(context).convertConfigToWidget(child));
            }).toList()));

        for (int i = 0; i < childrenData.length - 1; i++) {
          children.add(NabiDivider(
            direction: widget.direction,
            color: const Color(0xff333333),
            position: (widget.direction == Axis.horizontal
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
