// import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import "package:flutter/material.dart";
// import 'package:welding_app/constants.dart';
// import 'package:path_provider/path_provider.dart';
// import 'models/balcony.dart';

// class AddProduct extends StatefulWidget {
//   const AddProduct({Key? key}) : super(key: key);

//   @override
//   State<AddProduct> createState() => _AddProductState();
// }

// class _AddProductState extends State<AddProduct> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: primaryColor,
//       ),
//       body: ListView(
//         children: [
//           ElevatedButton(
//               onPressed: () async {
//                 print(balcony.length);
//                 balcony.forEach((element) async {
//                   await FirebaseFirestore.instance
//                       .collection("products")
//                       .doc("balcony")
//                       .collection("balcony")
//                       .add(element)
//                       .then(
//                     (value) {
//                       FirebaseFirestore.instance
//                           .collection("products")
//                           .doc("balcony")
//                           .collection("balcony")
//                           .doc(value.id)
//                           .update({"prodId": value.id}).then(
//                               (value) => print("Updated Prod ID"));
//                     },
//                   );
//                 });
//               },
//               child: const Text("ADD PRODUCT"))
//         ],
//       ),
//     );
//   }
// }
