import 'package:flutter/widgets.dart';
import 'package:nabi/nabi.dart';

class BArguments {
  BArguments(this.color);

  final Color color;
}

class BPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var arguments = NabiWidget.of(context).layout.arguments as BArguments;

    return Container(
      child: Center(
        child: Text("B"),
      ),
      color: arguments.color,
    );
  }
}
