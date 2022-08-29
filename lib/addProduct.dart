import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:welding_app/constants.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  var prod = {
    "prodId": 41,
    "name": "Advanced New Windows",
    "price": 1000000,
    "image": ["assets/images/gate.jpg"],
    "description": "Very durable product made from the finest materials.",
  };

  var prodStream = FirebaseFirestore.instance
      .collection("products")
      .doc("gypsum")
      .collection("gypsum");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
      ),
      body: ListView(
        children: [
          ElevatedButton(
              onPressed: () {
                prodStream
                    .add(prod)
                    .then((value) => print("Product Added to cloud"));
              },
              child: const Text("ADD PRODUCT"))
        ],
      ),
    );
  }
}
