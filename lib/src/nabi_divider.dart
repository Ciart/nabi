import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

const double size = 4;

class NabiDivider extends StatefulWidget {
  const NabiDivider({Key? key, required this.axis, required this.color})
      : super(key: key);

  final Axis axis;
  final Color color;

  @override
  _NabiDividerState createState() => _NabiDividerState();
}

class _NabiDividerState extends State<NabiDivider> {
  bool _isHover = false;
  int _position = 0;

  void _onEnter(PointerEnterEvent event) {
    setState(() {
      _isHover = true;
    });
  }

  void _onExit(PointerExitEvent event) {
    setState(() {
      _isHover = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    InteractiveViewer
    return Container(
        child: widget.axis == Axis.horizontal
            ? _buildHorizontal()
            : _buildVertical());
  }

  Widget _buildHorizontal() {
    return Padding(
      padding: EdgeInsets.only(left: max(_position - size / 2, 0)),
      child: MouseRegion(
        cursor: SystemMouseCursors.resizeLeftRight,
        onEnter: _onEnter,
        onExit: _onExit,
        child: GestureDetector(
          child: AnimatedContainer(
            width: size,
            color: _isHover ? widget.color : widget.color.withOpacity(0),
            duration: const Duration(milliseconds: 100),
            curve: Curves.easeInOut,
          ),
        ),
      ),
    );
  }

  Widget _buildVertical() {
    return Padding(
      padding: EdgeInsets.only(top: max(_position - size / 2, 0)),
      child: MouseRegion(
        cursor: SystemMouseCursors.resizeUpDown,
        onEnter: _onEnter,
        onExit: _onExit,
        child: GestureDetector(
          child: AnimatedContainer(
            height: size,
            color: _isHover ? widget.color : widget.color.withOpacity(0),
            duration: const Duration(milliseconds: 100),
            curve: Curves.easeInOut,
          ),
        ),
      ),
    );
  }
}
