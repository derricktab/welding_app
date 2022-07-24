import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  var _cartItems;
  var prefs;

  // initialize shared preferences
  initSharedPrefs() async {
    prefs = await SharedPreferences.getInstance();
    _cartItems = prefs.getInt("cartItems");

    setState(() {});
  }

  // init state method
  @override
  void initState() {
    initSharedPrefs();
  }

  var cartItems = [
    {
      "prodId": 12,
      "image": "assets/images/welder.jpg",
      "prodName": "Metallic Window",
      "quantity": 3,
      "price": 40000
    },
    {
      "prodId": 12,
      "image": "assets/images/roof.jpg",
      "prodName": "Metallic Window",
      "quantity": 3,
      "price": 40000
    },
    {
      "prodId": 12,
      "image": "assets/images/w4.jpg",
      "prodName": "Metallic Window",
      "quantity": 3,
      "price": 40000
    },
    {
      "prodId": 12,
      "image": "assets/images/roof.jpg",
      "prodName": "Metallic Window",
      "quantity": 3,
      "price": 40000
    },
    {
      "prodId": 12,
      "image": "assets/images/w4.jpg",
      "prodName": "Metallic Window",
      "quantity": 3,
      "price": 40000
    },
    {
      "prodId": 12,
      "image": "assets/images/roof.jpg",
      "prodName": "Metallic Window",
      "quantity": 3,
      "price": 40000
    },
    {
      "prodId": 12,
      "image": "assets/images/w4.jpg",
      "prodName": "Metallic Window",
      "quantity": 3,
      "price": 40000
    },
    {
      "prodId": 12,
      "image": "assets/images/roof.jpg",
      "prodName": "Metallic Window",
      "quantity": 3,
      "price": 40000
    },
    {
      "prodId": 12,
      "image": "assets/images/w4.jpg",
      "prodName": "Metallic Window",
      "quantity": 3,
      "price": 40000
    },
  ];

  final _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
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
                            color: const Color.fromARGB(255, 95, 255, 89),
                            borderRadius: BorderRadius.circular(50)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 2),
                        child: Text(_cartItems.toString()),
                      ))
                ],
              ),
            ),
          ],
        ),
        body: ListView(
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
                children: cartItems.map((item) {
                  return Dismissible(
                    key: GlobalKey(),
                    background: Container(
                      decoration: const BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(40),
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
                    direction: DismissDirection.endToStart,
                    child: CartItem(
                        imagePath: item["image"].toString(),
                        itemName: item["prodName"].toString(),
                        Price: item["price"].toString(),
                        Quanity: item["quantity"].toString()),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 40),
            // TOTAL
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Total",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Text("UGX 500,000",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))
              ],
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
                setState(() {});
              },
              child: const Text("CHECKOUT"),
            ),
          ],
        ));
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
        ClipRRect(
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(40), bottomLeft: Radius.circular(40)),
          child: Image.asset(
            imagePath,
            width: 150,
            height: 110,
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
