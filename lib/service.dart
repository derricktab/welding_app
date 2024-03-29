import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'models/products.dart';

class OurService extends StatefulWidget {
  final category;

  const OurService({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  State<OurService> createState() => _OurServiceState();
}

class _OurServiceState extends State<OurService> {
  var _cartItems = 0;
  var image;
  var prodName;
  var price;
  var description;

  // DIALOG BOX TO CONFIRM ADD TO CART OPERATION
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                "assets/images/success.png",
                width: 90,
              ),
              const Text("SUCCESS")
            ],
          ),
          content: const Text(
            'Your Item Has Been Added To The Cart Succesfully!',
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Continue Shopping',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                'Go To Cart',
                style: TextStyle(fontSize: 18, color: Colors.green),
              ),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.pushNamed(context, "cart");
              },
            ),
          ],
        );
      },
    );
  }

  var _liked = false;
  int _current = 0;
  final CarouselController _controller = CarouselController();

  var dropdownValue = "Select Size";

  // HEART COLOR
  var _heartColor = Colors.black;

  // PRODUCT COLOR
  var _prodColor = Colors.black;

  // INITIAL VALUE OF QUANTITY
  int _currentHorizontalIntValue = 1;

// METHOD TO ADD PRODUCT TO CART
  addToCart(product) {
    FirebaseFirestore.instance.collection("cart").add(product).then((value) {
      var id = value.id;
      print(id);
      FirebaseFirestore.instance
          .collection("cart")
          .doc(id)
          .update({"prodId": id});
      _showMyDialog();
    }, onError: (error) => print("$error"));
  }

  getCartItems() {
    var uid;
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      uid = user.uid;
    }
    var _cartStream = FirebaseFirestore.instance
        .collection("cart")
        .where("user", isEqualTo: uid)
        .snapshots();

    // GETTING THE CURRENT STREAM
    _cartStream.listen((snapshot) {
      if (this.mounted) {
        setState(() {
          _cartItems = snapshot.docs.length;
        });
      }
    });
  }

  var _products = <Map<String, dynamic>>[];

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
    getCartItems();
    List<String> imgList = [];

    List _imgList = _products[0]["image"];
    _imgList.forEach((element) {
      imgList.add(element);
    });

    final _prodName = _products[0]["name"];

    final _price = _products[0]["price"];

    final _description = _products[0]["description"];

// IMAGE SLIDERS
    final List<Widget> imageSliders = imgList
        .map((item) => Container(
              margin: EdgeInsets.all(5.0),
              height: 600,
              child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                  child: Stack(
                    children: <Widget>[
                      CachedNetworkImage(
                        imageUrl: item,
                        placeholder: (context, url) {
                          return Image.asset("assets/images/placeholder.gif");
                        },
                        fit: BoxFit.cover,
                        width: 1000.0,
                        height: 400,
                      ),
                    ],
                  )),
            ))
        .toList();

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 229, 255, 231),
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.chevron_left,
              size: 40,
            )),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
        actions: [
          // SHOPPING CART ICON
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, "cart");
            },
            child: Stack(
              alignment: AlignmentDirectional.centerEnd,
              children: [
                Container(
                    margin: const EdgeInsets.only(right: 25),
                    child: const Icon(
                      Icons.shopping_cart,
                      // size: 20,
                    )),

                // CART ITEMS NUMBER
                Positioned(
                  top: 5,
                  right: 0,
                  child: Container(
                    margin: const EdgeInsets.only(right: 12),
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 45, 61, 50),
                        borderRadius: BorderRadius.circular(50)),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                    child: Text(
                      _cartItems.toString(),
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          // CAROUSEL SLIDE
          CarouselSlider(
            items: imageSliders,
            carouselController: _controller,
            options: CarouselOptions(
                height: 300,
                autoPlay: false,
                enlargeCenterPage: true,
                aspectRatio: 2.0,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                }),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: imgList.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => _controller.animateToPage(entry.key),
                child: Container(
                  width: 12.0,
                  height: 12.0,
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: (Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black)
                          .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                ),
              );
            }).toList(),
          ),

          // TEXT CONTAINER
          Container(
            height: 500,
            padding: const EdgeInsets.only(top: 30, right: 30, left: 30),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black,
                      offset: Offset.fromDirection(20),
                      spreadRadius: 0.5,
                      blurRadius: 8),
                ]),
            child: ListView(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(height: 17),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _products[0]["name"],
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),

                    // ADD TO FAVORITES
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _liked = _liked ? false : true;
                          _heartColor = _liked ? Colors.red : Colors.black;
                        });
                      },
                      child: _liked
                          ? Icon(
                              Icons.favorite,
                              color: _heartColor,
                              size: 25,
                            )
                          : Icon(
                              FontAwesomeIcons.heart,
                              color: _heartColor,
                            ),
                    )
                  ],
                ),
                const SizedBox(height: 25),

                // PRICE
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // PRICE
                    const Text(
                      "PRICE: ",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),

                    Text(
                      "~ ${_products[0]["price"]}",
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.green),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  _description,
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 30),

                // ADD TO CART BUTTON
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    backgroundColor: Colors.red,
                    shape: BeveledRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () async {
                    var currentUser = FirebaseAuth.instance.currentUser;
                    if (currentUser == null) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text(
                              "YOU ARE NOT LOGGED IN, PLEASE LOGIN IN FIRST.")));
                      Navigator.pushNamed(context, "login");
                    } else {
                      var item = {
                        'prodId': _products[0]["prodId"],
                        "image": _products[0]["image"][0],
                        "prodName": _products[0]["name"],
                        "quantity": _currentHorizontalIntValue,
                        "price": _products[0]["price"],
                        "user": currentUser.uid,
                      };

                      addToCart(item);
                    }
                  },
                  child: const Text(
                    "ADD TO CART",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          )
        ],
      ),
    );
  }
}
