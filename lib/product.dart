import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Product extends StatefulWidget {
  final String image;
  final String prodName;
  final String price;
  final String description;

  const Product({
    Key? key,
    required this.image,
    required this.prodName,
    required this.price,
    required this.description,
  }) : super(key: key);

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  var _cartItems = 0;

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

  @override
  Widget build(BuildContext context) {
    getCartItems();

    var imgList = [widget.image];

    final _prodName = widget.prodName;

    final _price = widget.price;

    final _description = widget.description;

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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _prodName,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
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
                const SizedBox(height: 11),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // RATING STARS
                    RatingBar.builder(
                        initialRating: 3.5,
                        minRating: 1,
                        itemCount: 5,
                        itemSize: 26,
                        allowHalfRating: true,
                        itemBuilder: ((context, index) => const Icon(
                              Icons.star,
                              color: Colors.orange,
                            )),
                        onRatingUpdate: (rating) {
                          print(rating);
                        }),

                    // PRICE
                    Text(
                      _price,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.green),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  _description,
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Quantity: ",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () => setState(() {
                            final newValue = _currentHorizontalIntValue - 1;
                            _currentHorizontalIntValue = newValue.clamp(1, 100);
                          }),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 225, 248, 222),
                              borderRadius: BorderRadius.circular(6)),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 3),
                          child: Text(
                            _currentHorizontalIntValue.toString(),
                            style: const TextStyle(
                                fontSize: 14, color: Colors.black),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () => setState(() {
                            final newValue = _currentHorizontalIntValue + 1;
                            _currentHorizontalIntValue = newValue.clamp(1, 100);
                          }),
                        ),
                      ],
                    ),
                  ],
                ),

                // COLOR
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // SELECTING COLOR
                    const Text(
                      "Color: ",
                      textAlign: TextAlign.right,
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        // black
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _prodColor = Colors.black;
                            });
                          },
                          icon: _prodColor == Colors.black
                              ? const Icon(Icons.check_circle)
                              : const Icon(Icons.circle),
                        ),

                        // red
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _prodColor = Colors.red;
                            });
                          },
                          icon: _prodColor == Colors.red
                              ? Icon(
                                  Icons.check_circle,
                                  color: _prodColor,
                                )
                              : const Icon(
                                  Icons.circle,
                                  color: Color.fromARGB(255, 231, 41, 28),
                                ),
                        ),

                        // grey
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _prodColor = Colors.grey;
                            });
                          },
                          icon: _prodColor == Colors.grey
                              ? Icon(
                                  Icons.check_circle,
                                  color: _prodColor,
                                )
                              : const Icon(
                                  Icons.circle,
                                  color: Colors.grey,
                                ),
                        ),

                        // green
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _prodColor = Colors.green;
                            });
                          },
                          icon: _prodColor == Colors.green
                              ? Icon(
                                  Icons.check_circle,
                                  color: _prodColor,
                                )
                              : const Icon(
                                  Icons.circle,
                                  color: Colors.green,
                                ),
                        ),
                      ],
                    ),
                  ],
                ),

                // SIZE
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Size: ",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    DropdownButton<String>(
                      // Step 3.
                      value: dropdownValue,
                      // Step 4.
                      items: <String>[
                        'Select Size',
                        '200 x 300 Inch',
                        '300 x 300 Inch',
                        '400 x 500 Inch',
                        '500 x 500 Inch'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(fontSize: 16),
                          ),
                        );
                      }).toList(),
                      // Step 5.
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                        });
                      },
                    ),
                  ],
                ),

                // ADD TO CART BUTTON
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: BeveledRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () async {
                    var user = FirebaseAuth.instance.currentUser;
                    if (user != null) {
                      var uid = user.uid;

                      var item = {
                        'prodId': 12,
                        "image": imgList[0],
                        "prodName": _prodName,
                        "quantity": _currentHorizontalIntValue,
                        "price": _price,
                        "user": uid
                      };

                      addToCart(item);
                    } else {
                      print("NO USER SIGNED IN");
                    }
                    // _showMyDialog();
                    // setState(() {});
                  },
                  child: const Text("ADD TO CART"),
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
