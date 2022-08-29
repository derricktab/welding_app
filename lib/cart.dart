import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class Cart extends StatefulWidget {
  const Cart({
    Key? key,
  }) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  var _cartItems;
  var _total = 0;
  var cartItems = [];

  // initialize shared preferences

  // initSharedPrefs() async {
  //   prefs = await SharedPreferences.getInstance();
  //   var decodedList = [];

  //   try {
  //     var items = await prefs.getStringList("items");
  //     setState(() {
  //       _cartItems = items!.length;
  //       _total = 0;

  //       cartItems = items;

  //       cartItems.forEach((element) {
  //         var decoded_element = jsonDecode(element);

  //         decodedList.add(decoded_element);
  //       });

  //       cartItems = decodedList;
  //       print("cart items $decodedList");
  //     });
  //   } catch (exception) {
  //     await prefs.setStringList("items", <String>[]);
  //     print("set new value");
  //     print(exception);
  //   }

  //   setState(() {});
  // }

// Cart Stream
  var cartStream = FirebaseFirestore.instance.collection("cart").snapshots();

  // adding commas to numbers
  var f = NumberFormat.decimalPattern('en_us');

  // init state method
  @override
  void initState() {
    // initSharedPrefs();
  }

  @override
  Widget build(BuildContext context) {
    cartStream.listen((snapshot) {
      setState(() {
        _cartItems = snapshot.docs.length;
      });
    });

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.chevron_left,
              size: 40,
            )),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          // SHOPPING CART ICON
          GestureDetector(
            onTap: () {},
            child: Stack(
              alignment: AlignmentDirectional.centerEnd,
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 20),
                  child: const Icon(
                    Icons.shopping_cart,
                    size: 30,
                  ),
                ),
                // CART ITEMS NUMBER
                Positioned(
                    top: 5,
                    right: 0,
                    child: Container(
                        margin: const EdgeInsets.only(right: 12),
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(50)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 2),
                        child: Text(
                          _cartItems.toString(),
                          style: const TextStyle(color: Colors.white),
                        )

                        // StreamBuilder<QuerySnapshot>(
                        //     stream: cartStream,
                        //     builder: ((context, snapshot) {
                        //       return Text(
                        //         snapshot.data!.size.toString(),
                        //         style: const TextStyle(color: Colors.white),
                        //       );
                        //     })),
                        ))
              ],
            ),
          ),
        ],
      ),
      body: _cartItems > 0
          ? ListView(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 28, left: 15),
                  child: Text(
                    "SHOPPING \nCART",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Color.fromARGB(255, 16, 110, 19),
                        fontFamily: "times"),
                  ),
                ),

                // CART ITEMS
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: cartItems
                        .asMap()
                        .map((index, item) {
                          // calculating the total
                          print(item["price"].runtimeType);
                          int price = int.parse(item["price"]);
                          int quantity = int.parse(item["quantity"].toString());

                          setState(() {
                            _total += (price * quantity);
                            print(_total);
                          });
                          return MapEntry(
                            index,
                            Dismissible(
                              key: GlobalKey(),
                              background: Container(
                                decoration: const BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(40),
                                      bottomRight: Radius.circular(40),
                                    )),
                              ),
                              confirmDismiss: (direction) async {
                                var response = await showDialog<bool>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      content: const Text(
                                          'Are You Sure You Want To Remove This Item From Cart?'),
                                      actions: <Widget>[
                                        TextButton(
                                            child: const Text('Yes'),
                                            // Return "true" when dismissed.
                                            onPressed: () =>
                                                Navigator.pop(context, true)),
                                        TextButton(
                                            child: const Text('No'),
                                            // Return "false" when dismissed.
                                            onPressed: () =>
                                                Navigator.pop(context, false)),
                                      ],
                                    );
                                  },
                                );

                                return response;
                              },
                              onDismissed: (direction) async {
                                // GOING TO IMPLEMENT
                              },
                              direction: DismissDirection.endToStart,
                              child: CartItem(
                                  imagePath: item["image"].toString(),
                                  itemName: item["prodName"].toString(),
                                  Price: f
                                      .format(int.parse(item["price"]))
                                      .toString(),
                                  Quanity: item["quantity"].toString()),
                            ),
                          );
                        })
                        .values
                        .toList(),
                  ),
                ),
                const SizedBox(height: 40),

                // TOTAL
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Total: ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Text("UGX ${f.format(_total)}",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20))
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // CHECKOUT BUTTON
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    shape: BeveledRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () async {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, "checkout");
                    // await prefs.setStringList("items", <String>[]);
                    // print("cart cleared");
                  },
                  child: const Text("CHECKOUT"),
                ),
              ],
            )

          // if there is no item in the cart
          : Column(
              children: [
                Image.asset("assets/images/empty.jpg"),

                const SizedBox(height: 30),

                const Text(
                  "IT FEELS EMPTY IN HERE",
                  style: TextStyle(fontSize: 18),
                ),

                const SizedBox(height: 50),

                //PLACE ORDER BUTTON
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                      shape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () async {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, "services");
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 15.0),
                      child: Text("LETS GO SHOPPING"),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

// SINGLE ROW OF THE CART ITEMS
class CartItem extends StatelessWidget {
  final imagePath;
  final itemName;
  final Price;
  final Quanity;

  const CartItem(
      {Key? key,
      required this.imagePath,
      required this.itemName,
      required this.Price,
      required this.Quanity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // product image
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(40), bottomLeft: Radius.circular(40)),
            child: Image.asset(
              imagePath,
              width: 150,
              height: 110,
            ),
          ),
        ),
        Container(
          child: Row(
            children: [
              Column(
                children: [
                  // item name
                  Text(
                    itemName,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                    softWrap: true,
                  ),

                  // price
                  Text("UGX " + Price)
                ],
              )
            ],
          ),
        ),

        // quantity
        Text("X " + Quanity)
      ],
    );
  }
}
