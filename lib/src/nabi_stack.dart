import 'package:flutter/widgets.dart';
import 'package:nabi/nabi.dart';

class NabiStack extends StatefulWidget {
  const NabiStack({Key? key, required this.data}) : super(key: key);

  final LayoutGroup data;

  @override
  _NabiStackState createState() => _NabiStackState();
}

class _NabiStackState extends State<NabiStack> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: widget.data.children.map((e) => Text(e.id)).toList(),
        ),
        Expanded(
            child: Nabi.of(context)
                .convertConfigToWidget(widget.data.children![0]))
      ],
    );
  }
}
