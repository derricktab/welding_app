import 'package:flutter/material.dart';
import 'package:welding_app/single_product.dart';
import 'models/products.dart';

class ProdList extends StatefulWidget {
  final category;

  const ProdList({Key? key, required this.category}) : super(key: key);

  @override
  State<ProdList> createState() => _ProdListState();
}

var _products = <Map<String, dynamic>>[];

class _ProdListState extends State<ProdList> {
  // Method to fetch products
  getItems(category) {
    List<Map<String, dynamic>> products = Products(category).returnProdList();

    setState(() {
      _products = products;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getItems(widget.category);
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
