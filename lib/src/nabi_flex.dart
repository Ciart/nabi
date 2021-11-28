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
    var direction = widget.layout.direction;

    return LayoutBuilder(
        builder: (context, constraints) => Stack(children: [
              Flex(
                  direction: direction,
                  children: widget.layout.children.map((e) {
                    return Flexible(
                        flex: e.size,
                        child: Nabi.of(context).convertConfigToWidget(e));
                  }).toList()),
              NabiDivider(
                direction: direction,
                color: const Color(0xff333333),
                position: constraints.maxWidth * _ratios[0],
              ),
              NabiDivider(
                direction: direction,
                color: const Color(0xff333333),
                position: constraints.maxWidth * _ratios[1],
              )
            ]));
  }

  int computeSum(List<int> list) {
    var sum = 0;

    for (var item in list) {
      sum += item;
    }

    return sum;
  }
}
