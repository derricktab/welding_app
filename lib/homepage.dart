import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:outline_search_bar/outline_search_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:welding_app/mini_item.dart';
import 'package:welding_app/mini_services.dart';
import 'constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var prefs;

  // METHOD TO DISPLAY ALERT DIALOG FOR CONTACT
  showAlertDialog() {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                "assets/images/contact1.png",
                width: 90,
              ),
              const Text("Contact Us")
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              children: [
                // ADDRESS
                Row(
                  children: const [
                    Text(
                      'ADDRESS: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Nsangi, Manja Zone, \n2KM off Nsangi Stage',
                      softWrap: true,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // EMAIL
                Row(
                  children: const [
                    Text(
                      'EMAIL: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'info@inventionplusgroup.com',
                      softWrap: true,
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // PHONE NUMBER
                Row(
                  children: const [
                    Text(
                      'PHONE NUMBER: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '+256392175187 \n +256702078598',
                      softWrap: true,
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Send Us An Email',
                style: TextStyle(fontSize: 18, color: Colors.green),
              ),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, "contact");
              },
            ),
          ],
        );
      },
    );
  }

  var _cartItems;

  initSharedPrefs() async {
    var prefs = await SharedPreferences.getInstance();

    try {
      var items = await prefs.getStringList("items");
      setState(() {
        _cartItems = items!.length;
      });
      print(items.toString());
      print("cart items set");
    } catch (exception) {
      await prefs.setStringList("items", <String>[]);
      print("set new value");
    }

    setState(() {});
  }

// init state method
  @override
  void initState() {
    // TODO: implement initState
    initSharedPrefs();
  }

  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  bool drawerOpen = false;
  double radius = 0;
  bool isHome = true;
  bool isServices = false;
  bool isContact = false;
  Color? activeColor = Colors.white;
  Color? inactiveColor = Color.fromARGB(255, 167, 164, 140);
  var _textController = TextEditingController();

  int _current = 0;
  final CarouselController _controller = CarouselController();

// IMAGE LIST
  final List<String> imgList = [
    'assets/images/gypsum3.jpeg',
    'assets/images/mdoor5.jpeg',
    'assets/images/gate3.jpg',
    'assets/images/window4.jpeg',
  ];

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
    return GestureDetector(
      onTap: drawerOpen
          ? () {
              setState(() {
                xOffset = 0;
                yOffset = 0;
                scaleFactor = 1;
                drawerOpen = false;
                radius = 0;
              });
            }
          : null,
      child: AnimatedContainer(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.black,
          ),
          duration: const Duration(milliseconds: 400),
          transform: Matrix4.translationValues(xOffset, yOffset, 1)
            ..scale(scaleFactor),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(radius),
            child: Scaffold(
              backgroundColor: Color.fromARGB(255, 249, 255, 249),
              // APPBAR
              appBar: AppBar(
                elevation: 0,
                backgroundColor: primaryColor,
                title: const Text("Invention Plus Group"),
                leading: drawerOpen
                    ? IconButton(
                        icon: const Icon(FontAwesomeIcons.chevronLeft),
                        onPressed: () {
                          drawerOpen = false;
                          setState(() {
                            xOffset = 0;
                            yOffset = 0;
                            scaleFactor = 1;
                            radius = 0;
                          });
                        },
                      )
                    : IconButton(
                        icon: const Icon(Icons.menu),
                        onPressed: () {
                          drawerOpen = true;
                          setState(() {
                            xOffset = 250;
                            yOffset = 180;
                            scaleFactor = 0.65;
                            radius = 60;
                          });
                        },
                      ),
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
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 2),
                              child: Text(_cartItems.toString()),
                            ))
                      ],
                    ),
                  ),

                  // User Profile
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: GestureDetector(
                      child: const CircleAvatar(
                        radius: 15,
                        foregroundImage: AssetImage("assets/images/logo.jpg"),
                        foregroundColor: Colors.yellow,
                        backgroundColor: Colors.black,
                        child: Text("DZ"),
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, "profile");
                      },
                    ),
                  ),
                ],
              ),

              // BODY OF THE APP
              body: ListView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                children: [
                  // CAROUSEL SLIDE
                  CarouselSlider(
                    items: imageSliders,
                    carouselController: _controller,
                    options: CarouselOptions(
                        height: 250,
                        autoPlay: true,
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
                              color: (Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.white
                                      : Colors.black)
                                  .withOpacity(
                                      _current == entry.key ? 0.9 : 0.4)),
                        ),
                      );
                    }).toList(),
                  ),
                  // SEARCH BAR
                  Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        40,
                      ),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.green,
                            offset: Offset.fromDirection(2),
                            blurRadius: 5,
                            blurStyle: BlurStyle.outer),
                        BoxShadow(
                            color: Colors.black,
                            blurRadius: 8,
                            blurStyle: BlurStyle.inner),
                      ],
                      color: Colors.transparent,
                    ),

                    // search input box
                    child: OutlineSearchBar(
                      textEditingController: _textController,
                      borderRadius: BorderRadius.circular(25),
                      hintText: "Search Product",
                      elevation: 3,
                      clearButtonColor: Colors.black,
                      borderColor: Colors.black,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                    ),
                  ),

                  const SizedBox(height: 15),

                  // SERVICES SECTION HEAD
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Services",
                          style: TextStyle(
                              fontSize: 19, fontWeight: FontWeight.bold),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, "services");
                          },
                          child: const Text("See All"),
                        )
                      ],
                    ),
                  ),

                  // SERVICES SECTION
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          // WINDOWS
                          MiniServices(
                            img: "assets/images/w4.jpg",
                            service: "Windows",
                          ),

                          // METAL DOORS
                          MiniServices(
                            img: "assets/images/d2.webp",
                            service: "Metal Doors",
                          ),

                          // BALCONY
                          MiniServices(
                            img: "assets/images/b3.png",
                            service: "Balcony",
                          ),

                          // ROOFING
                          MiniServices(
                            img: "assets/images/roofing.png",
                            service: "Roofing",
                          ),

                          // WOODEN DOORS
                          MiniServices(
                            img: "assets/images/wdoor1.jpg",
                            service: "Wood Doors",
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),

                  // POPULAR DESIGNS SECTION HEAD
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Popular Designs",
                          style: TextStyle(
                              fontSize: 19, fontWeight: FontWeight.bold),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, "services");
                          },
                          child: const Text("See All"),
                        )
                      ],
                    ),
                  ),

                  // POPULAR PRODUCTS SECTION
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          MiniItem(
                            image: "assets/images/w1.jpg",
                            prodName: "Window",
                            price: "200000",
                            description:
                                "Very durable product made from the finest materials.",
                          ),
                          MiniItem(
                            image: "assets/images/wdoor1.jpg",
                            prodName: "Interior Door",
                            price: "260000",
                            description:
                                "Very durable product made from the finest materials.",
                          ),
                          MiniItem(
                            image: "assets/images/d1.jpg",
                            prodName: "Door",
                            price: "500000",
                            description:
                                "Very durable product made from the finest materials.",
                          ),
                          MiniItem(
                            image: "assets/images/balcony.jpg",
                            prodName: "Balcony",
                            price: "600000",
                            description:
                                "Very durable product made from the finest materials.",
                          ),
                          MiniItem(
                            image: "assets/images/roof.jpg",
                            prodName: "Roofing",
                            price: "3000000",
                            description:
                                "Very durable product made from the finest materials.",
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 35),
                ],
              ),

              // BOTTOM NAVIGATION BAR
              bottomNavigationBar: BottomAppBar(
                // shape: const CircularNotchedRectangle(),
                // notchMargin: 6,
                color: primaryColor,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // HOME BUTTON
                      GestureDetector(
                        onTap: () {
                          setState(() {});
                        },
                        child: Row(
                          children: [
                            Icon(FontAwesomeIcons.houseChimney,
                                color: activeColor),
                            const SizedBox(width: 12),
                            Text(
                              "HOME",
                              style: TextStyle(color: activeColor),
                            ),
                          ],
                        ),
                      ),
                      const Text(
                        "|",
                        style: TextStyle(color: Colors.white),
                      ),
                      // CONTACT BUTTON
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isHome = false;
                            isContact = true;
                          });
                          showAlertDialog();
                        },
                        child: Row(
                          children: [
                            Icon(FontAwesomeIcons.phone, color: inactiveColor),
                            const SizedBox(width: 10),
                            Text(
                              "CONTACT",
                              style: TextStyle(color: inactiveColor),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // // CAMERA FLOATING ACTION BUTTON
              // floatingActionButton: FloatingActionButton(
              //   backgroundColor: Colors.black,
              //   onPressed: () async {
              //     showDialog(
              //         context: context,
              //         builder: (BuildContext context) => _popupDialog(context));
              //   },
              //   child: const Icon(FontAwesomeIcons.camera),
              // ),

              // FLOATING ACTION BUTTON LOCATION
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
            ),
          )),
    );
  }
}
