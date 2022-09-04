import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
// MAIN DOORS
                var maindoors = <Map<String, dynamic>>[
                  {
                    "prodId": 01,
                    "name": "Main Door",
                    "price": 2000000 - 2900000,
                    "image": "assets/images/mdoor.jpeg",
                    "description":
                        "Very durable product made from the finest materials.",
                  },
                  {
                    "prodId": 01,
                    "name": "Main Door",
                    "price": 2000000 - 2900000,
                    "image": "assets/images/mdoor.jpg",
                    "description":
                        "Very durable product made from the finest materials.",
                  },
                  {
                    "prodId": 02,
                    "name": "Main Door",
                    "price": 2000000 - 2900000,
                    "image": "assets/images/mdoor1.jpeg",
                    "description":
                        "Very durable product made from the finest materials.",
                  },
                  {
                    "prodId": 03,
                    "name": "Main Door",
                    "price": 2000000 - 2900000,
                    "image": "assets/images/mdoor2.jpeg",
                    "description":
                        "Very durable product made from the finest materials.",
                  },
                  {
                    "prodId": 04,
                    "name": "Main Door",
                    "price": 2000000 - 2900000,
                    "image": "assets/images/mdoor3.jpeg",
                    "description":
                        "Very durable product made from the finest materials.",
                  },
                  {
                    "prodId": 04,
                    "name": "Main Door",
                    "price": 2000000 - 2900000,
                    "image": "assets/images/mdoor4.jpeg",
                    "description":
                        "Very durable product made from the finest materials.",
                  },
                  {
                    "prodId": 04,
                    "name": "Main Door",
                    "price": 2000000 - 2900000,
                    "image": "assets/images/mdoor5.jpeg",
                    "description":
                        "Very durable product made from the finest materials.",
                  },
                  {
                    "prodId": 04,
                    "name": "Main Door",
                    "price": 2000000 - 2900000,
                    "image": "assets/images/mdoor6.jpeg",
                    "description":
                        "Very durable product made from the finest materials.",
                  },
                ];

                FirebaseStorage.instance
                    .ref()
                    .child("products/")
                    .putFile(File(""))
                    .then((p0) async {
                  print(await p0.ref.getDownloadURL());
                });
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
