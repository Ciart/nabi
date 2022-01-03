import 'package:flutter/material.dart';
import 'package:nabi/nabi.dart';

class Counter extends StatefulWidget {
  const Counter({Key? key}) : super(key: key);

  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(_count.toString()),
        TextButton(
            onPressed: () {
              setState(() {
                Nabi.of(context).layout.addChild(
                    Nabi.of(context).layout.root.id, LayoutWidget(name: 'a'));
              });
            },
            child: Text('Increased'))
      ],
    );
  }
}
