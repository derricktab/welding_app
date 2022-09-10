import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Cart extends StatefulWidget {
  const Cart({
    Key? key,
  }) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  var _cartItems = 0;
  var cartItems = [];

  var uid;

  // adding commas to numbers
  var f = NumberFormat.decimalPattern('en_us');

// GET CART ITEMS
  getCartItems() {
    // Cart Stream
    var cartStream = FirebaseFirestore.instance
        .collection("cart")
        .where({"user": uid}).snapshots();

    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      uid = user.uid;
    }

    cartStream.listen((snapshot) async {
      var items = [];

      // updating the cart
      snapshot.docs.forEach((doc) {
        items.add(doc.data());
      });

      setState(() {
        // updating the number of items in the cart
        _cartItems = snapshot.docs.length;
        cartItems = items;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    getCartItems();
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
            onTap: () {
              setState(() {});
            },
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
                        )))
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
                          String price = item["price"];
                          String quantity = item["quantity"].toString();
                          String prodId = item["prodId"].toString();

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
                                print(prodId);
                                // REMOVE ITEM FROM CART
                                FirebaseFirestore.instance
                                    .collection("cart")
                                    .doc(prodId.toString())
                                    .delete()
                                    .then((value) {
                                  print("Item Removed from cart");
                                  setState(() {});
                                });
                              },
                              direction: DismissDirection.endToStart,
                              child: CartItem(
                                  imagePath: item["image"].toString(),
                                  itemName: item["prodName"].toString(),
                                  Price: item["price"].toString(),
                                  Quanity: item["quantity"].toString()),
                            ),
                          );
                        })
                        .values
                        .toList(),
                  ),
                ),
                const SizedBox(height: 40),

                const SizedBox(height: 20),
                // CHECKOUT BUTTON
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: BeveledRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () async {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, "checkout");
                    // await prefs.setStringList("items", <String>[]);
                    // print("cart cleared");
                  },
                  child: const Text(
                    "CHECKOUT",
                    style: TextStyle(fontSize: 17),
                  ),
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
            child: CachedNetworkImage(
              imageUrl: imagePath,
              placeholder: (context, url) {
                return Image.asset("assets/images/placeholder.gif");
              },
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
                  Text("UGX $Price")
                ],
              )
            ],
          ),
        ),

        // quantity
        Text("X $Quanity")
      ],
    );
  }
}
