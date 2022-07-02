import 'package:flutter/material.dart';
import 'constants.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ORDERS"),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body: const Center(child: Text("THIS IS THE ORDERS PAGE")),
    );
  }
}
