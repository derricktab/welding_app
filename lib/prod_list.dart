import 'package:flutter/material.dart';

class ProdList extends StatefulWidget {
  final category;

  const ProdList({Key? key, required this.category}) : super(key: key);

  @override
  State<ProdList> createState() => _ProdListState();
}

class _ProdListState extends State<ProdList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.category),),
      body: Center(child: Text(widget.category),),
    );
  }
}
