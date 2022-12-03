import 'package:flutter/cupertino.dart';

class HorizontalScrollView extends StatelessWidget {
  final List<Widget> children;
  final EdgeInsets? margin;

  HorizontalScrollView({required this.children, this.margin});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(children: children),
      ),
    );
  }
}