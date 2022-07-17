import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Product extends StatefulWidget {
  // final String prodId;

  const Product({
    Key? key,
    // required this.prodId
  }) : super(key: key);

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
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

  var _liked = false;
  int _current = 0;
  final CarouselController _controller = CarouselController();

// IMAGE LIST
  final List<String> imgList = [
    'assets/images/b3.png',
    'assets/images/bed.jpg',
    'assets/images/re.jpg',
  ];

  var dropdownValue = "Select Size";

  // HEART COLOR
  var _heartColor = Colors.black;

  // PRODUCT COLOR
  var _prodColor = Colors.black;

  // INITIAL VALUE OF QUANTITY
  int _currentHorizontalIntValue = 1;

  @override
  Widget build(BuildContext context) {
// IMAGE SLIDERS
    final List<Widget> imageSliders = imgList
        .map((item) => Container(
              margin: EdgeInsets.all(5.0),
              height: 600,
              child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                  child: Stack(
                    children: <Widget>[
                      Image.asset(
                        item,
                        fit: BoxFit.cover,
                        width: 1000.0,
                        height: 400,
                      ),
                    ],
                  )),
            ))
        .toList();

    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.chevron_left,
              size: 35,
            )),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          // SHOPPING CART ICON
          Stack(
            alignment: AlignmentDirectional.centerEnd,
            children: [
              Container(
                margin: const EdgeInsets.only(right: 20),
                child: const Icon(Icons.shopping_cart),
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                    child: Text(_cartItems.toString()),
                  ))
            ],
          ),
        ],
      ),
      body: ListView(
        children: [
          // CAROUSEL SLIDE
          Expanded(
            child: CarouselSlider(
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
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: imgList.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => _controller.animateToPage(entry.key),
                child: Container(
                  width: 12.0,
                  height: 12.0,
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
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
            height: 340,
            padding: const EdgeInsets.only(top: 30, right: 30, left: 30),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30))),
            child: ListView(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Metallic Window",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                    const Text(
                      "USH 230,000",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.green),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  "We have this window in different shapes, designs, colors and sizes.",
                  style: TextStyle(fontSize: 18),
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
                          icon: Icon(Icons.remove),
                          onPressed: () => setState(() {
                            final newValue = _currentHorizontalIntValue - 1;
                            _currentHorizontalIntValue = newValue.clamp(0, 100);
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
                            _currentHorizontalIntValue = newValue.clamp(0, 100);
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
                    primary: Colors.red,
                    shape: BeveledRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () async {
                    _cartItems += 1;
                    await prefs.setInt("cartItems", _cartItems);
                    var out = await prefs.getInt("cartItems");
                    print(out);
                    setState(() {});

                    print("ADD TO CART BUTTON CLICKED");
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
