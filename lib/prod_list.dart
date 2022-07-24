import 'package:flutter/material.dart';
import 'package:welding_app/single_product.dart';

class ProdList extends StatefulWidget {
  final category;

  const ProdList({Key? key, required this.category}) : super(key: key);

  @override
  State<ProdList> createState() => _ProdListState();
}

class _ProdListState extends State<ProdList> {
  var products = <Map<String, dynamic>>[
    {
      "prodId": 12,
      "name": "Bed",
      "price": 280000,
      "image": "assets/images/bed.jpg"
    },
    {
      "prodId": 12,
      "name": "Wooden Doors",
      "price": 200000,
      "image": "assets/images/door.jpg"
    },
    {
      "prodId": 12,
      "name": "Glassses",
      "price": 200000,
      "image": "assets/images/f1.jpg"
    },
    {
      "prodId": 12,
      "name": "Glass Windows",
      "price": 200000,
      "image": "assets/images/gate.jpg",
    },
    {
      "prodId": 12,
      "name": "Glass Windows",
      "price": 200000,
      "image": "assets/images/hr1.jpg"
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 239, 251, 247),
        // backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(widget.category),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: Colors.black,
        ),
        body: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          childAspectRatio: 0.8,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          children: products.map((product) {
            return SingleProduct(
              img: product["image"].toString(),
              prodName: product["name"].toString(),
              price: product["price"].toString(),
            );
          }).toList(),
        ));
  }
}
