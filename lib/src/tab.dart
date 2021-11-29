import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nabi/src/extension/extended_iterable.dart';

typedef TabChangeCallback = void Function(int index);

class Tab extends StatefulWidget {
  const Tab({Key? key, required this.titles, required this.onChange})
      : super(key: key);

  final List<String> titles;
  final TabChangeCallback onChange;

  @override
  _TabState createState() => _TabState();
}

class _TabState extends State<Tab> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: widget.titles
          .mapIndexed((e, i) => TextButton(
              onPressed: () {
                setState(() {
                  selectedIndex = i;
                  widget.onChange(i);
                });
              },
              child: Text(e)))
          .toList(),
    );
  }
}
