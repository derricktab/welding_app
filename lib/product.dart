import 'package:flutter/material.dart';

class Product extends StatefulWidget {
  const Product({Key? key}) : super(key: key);

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [Icon(Icons.shopping_basket)],
      ),
      body: ListView(
        children: [
          Container(child: Image.asset("name"),)
        ],
      ),
    );
  }
}
