import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:welding_app/single_product.dart';
import 'models/products.dart';

class Search extends StatefulWidget {
  final query;

  const Search({Key? key, required this.query}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  var _products = <Map<String, dynamic>>[];

  // Method to fetch products
  getItems(query) async {
    var result = await FirebaseFirestore.instance.collection("users").get();

    print(result.size);

    result.docs.forEach((doc) {
      _products.add(doc.data());
      print("${doc.id} ADDED!");
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getItems(widget.query);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _products.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 239, 251, 247),
        // backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.chevron_left,
                size: 40,
              )),
          title: Text(widget.query),
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
          children: _products.map((product) {
            return SingleProduct(
              img: product["image"].toString(),
              prodName: product["name"].toString(),
              price: product["price"].toString(),
              prodId: product["prodId"].toString(),
              description: product["description"].toString(),
            );
          }).toList(),
        ));
  }
}
