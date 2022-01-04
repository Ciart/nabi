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
  late List<double> _sizes;

  double get _totalSize => _computeSum(_sizes);

  void _init() {
    _sizes =
        widget.layout.children.map((child) => child.size.toDouble()).toList();
  }

  @override
  void initState() {
    super.initState();

    _init();
  }

  @override
  void didUpdateWidget(covariant NabiFlex oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.layout != widget.layout) {
      _init();
    }
  }

  @override
  Widget build(BuildContext context) {
    widget.layout.addListener(() => _init());

    return LayoutBuilder(builder: (context, constraints) {
      var maxSize = widget.layout.direction == Axis.horizontal
          ? constraints.maxWidth
          : constraints.maxHeight;

      return AnimatedBuilder(
          animation: widget.layout,
          builder: (context, child) => Stack(children: () {
                List<Widget> children = [];

                // TODO: 자식 테두리 빈 픽셀 수정, 자식 사이에 선 추가
                children.add(Flex(
                    direction: widget.layout.direction,
                    children: widget.layout.children.mapIndexed((child, i) {
                      if (child.isFlex) {
                        return Flexible(
                            flex: _sizes[i].toInt(),
                            child:
                                Nabi.of(context).convertConfigToWidget(child));
                      } else {
                        return SizedBox(
                            width: widget.layout.direction == Axis.horizontal
                                ? child.size.toDouble()
                                : null,
                            height: widget.layout.direction == Axis.vertical
                                ? child.size.toDouble()
                                : null,
                            child:
                                Nabi.of(context).convertConfigToWidget(child));
                      }
                    }).toList()));

                var position = 0.0;

                for (int i = 0; i < _sizes.length - 1; i++) {
                  position +=
                      _computeChildRenderSize(_sizes[i], _totalSize, maxSize);

                  children.add(NabiDivider(
                    direction: widget.layout.direction,
                    color: const Color(0xff333333),
                    position: position,
                    onDragUpdate: (details) {
                      setState(() {
                        _sizes = _sizes
                            .map((size) => _computeChildRenderSize(
                                size, _totalSize, maxSize))
                            .toList();

                        var delta = widget.layout.direction == Axis.horizontal
                            ? details.delta.dx
                            : details.delta.dy;

                        _sizes[i] += delta;
                        _sizes[i + 1] -= delta;
                      });
                    },
                    onDragEnd: (details) {
                      Nabi.of(context).layout.updateChildrenSize(
                          widget.layout.id,
                          _sizes.map((e) => e.toInt()).toList());
                    },
                  ));
                }
                return children;
              }()));
    });
  }

  double _computeSum(List<double> list) {
    var sum = 0.0;

    for (var item in list) {
      sum += item;
    }

    return sum;
  }

  double _computeChildRenderSize(
      double size, double totalSize, double maxSize) {
    return size / totalSize * maxSize;
  }
}
