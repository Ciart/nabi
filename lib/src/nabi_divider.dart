import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

typedef DividerDragCallback = void Function(DragUpdateDetails details);

const double size = 4;

class NabiDivider extends StatefulWidget {
  const NabiDivider(
      {Key? key,
      required this.direction,
      required this.color,
      required this.position,
      required this.onDrag})
      : super(key: key);

  final Axis direction;
  final Color color;
  final double position;

  final DividerDragCallback onDrag;

  @override
  _NabiDividerState createState() => _NabiDividerState();
}

class _NabiDividerState extends State<NabiDivider> {
  bool _isHover = false;

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

  void _onDragUpdate(DragUpdateDetails details) {
    widget.onDrag(details);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: widget.direction == Axis.horizontal
            ? _buildHorizontal()
            : _buildVertical());
  }

  Widget _buildHorizontal() {
    return Transform.translate(
      offset: Offset(widget.position - size / 2, 0.0),
      child: MouseRegion(
        cursor: SystemMouseCursors.resizeLeftRight,
        onEnter: _onEnter,
        onExit: _onExit,
        child: GestureDetector(
          onHorizontalDragUpdate: _onDragUpdate,
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
    return Transform.translate(
      offset: Offset(0.0, widget.position - size / 2),
      child: MouseRegion(
        cursor: SystemMouseCursors.resizeUpDown,
        onEnter: _onEnter,
        onExit: _onExit,
        child: GestureDetector(
          onVerticalDragUpdate: _onDragUpdate,
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
