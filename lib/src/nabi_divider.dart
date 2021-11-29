import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

typedef DividerDragUpdateCallback = void Function(DragUpdateDetails details);
typedef DividerDragEndCallback = void Function(DragEndDetails details);

const double size = 4;

class NabiDivider extends StatefulWidget {
  const NabiDivider(
      {Key? key,
      required this.direction,
      required this.color,
      required this.position,
      required this.onDragUpdate,
      required this.onDragEnd})
      : super(key: key);

  final Axis direction;
  final Color color;
  final double position;

  final DividerDragUpdateCallback onDragUpdate;
  final DividerDragEndCallback onDragEnd;

  @override
  _NabiDividerState createState() => _NabiDividerState();
}

class _NabiDividerState extends State<NabiDivider> {
  bool _isHover = false;
  bool _isDragged = false;

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

  void _onDragStart(DragStartDetails details) {
    setState(() {
      _isDragged = true;
    });
  }

  void _onDragUpdate(DragUpdateDetails details) {
    widget.onDragUpdate(details);
  }

  void _onDragEnd(DragEndDetails details) {
    setState(() {
      _isDragged = false;
    });

    widget.onDragEnd(details);
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
          onHorizontalDragStart: _onDragStart,
          onHorizontalDragUpdate: _onDragUpdate,
          onHorizontalDragEnd: _onDragEnd,
          child: AnimatedContainer(
            width: size,
            color: (_isHover || _isDragged)
                ? widget.color
                : widget.color.withOpacity(0),
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
          onVerticalDragStart: _onDragStart,
          onVerticalDragUpdate: _onDragUpdate,
          onVerticalDragEnd: _onDragEnd,
          child: AnimatedContainer(
            height: size,
            color: (_isHover || _isDragged)
                ? widget.color
                : widget.color.withOpacity(0),
            duration: const Duration(milliseconds: 100),
            curve: Curves.easeInOut,
          ),
        ),
      ),
    );
  }
}
