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
              print("clicked");
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
                          color: Colors.lightGreenAccent,
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
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Text(
              "SHOPPING \nCART",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.green,
                  fontFamily: "times"),
            ),
          ),
          const CartItem(
            imagePath: "assets/images/1.png",
            itemName: "Metallic Window",
            Price: "20,000",
            Quanity: "3",
          ),
          const CartItem(
            imagePath: "assets/images/re.jpg",
            itemName: "Metallic Door",
            Price: "20,000",
            Quanity: "2",
          ),
          const CartItem(
            imagePath: "assets/images/hr1.jpg",
            itemName: "Metallic Bed",
            Price: "50,000",
            Quanity: "1",
          ),
          const SizedBox(height: 100),

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
        ClipRRect(
          borderRadius: BorderRadius.circular(30),
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
