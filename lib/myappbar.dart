import 'package:flutter/material.dart';

class MyAppBar extends StatefulWidget{
  var bgColor;
  var title;

  MyAppBar({Key? key, this.bgColor, this.title}) : super(key: key);

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
