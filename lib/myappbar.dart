import 'package:flutter/material.dart';

class MyAppBar extends StatefulWidget{
  final bgColor;
  final title;

  const MyAppBar({Key? key, this.bgColor = Colors.green, this.title}) : super(key: key);

  @override
  State<MyAppBar> createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: widget.bgColor,
      foregroundColor: Colors.white,
      title: Text(widget.title),
    );
  }
}
