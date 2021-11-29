import 'package:flutter/widgets.dart';
import 'package:nabi/nabi.dart';

class NabiStack extends StatefulWidget {
  const NabiStack({Key? key, required this.layout}) : super(key: key);

  final LayoutStack layout;

  @override
  _NabiStackState createState() => _NabiStackState();
}

class _NabiStackState extends State<NabiStack> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: widget.layout.children.map((e) => Text(e.title)).toList(),
        ),
        Expanded(
            child: Nabi.of(context)
                .convertConfigToWidget(widget.layout.children[0]))
      ],
    );
  }
}
