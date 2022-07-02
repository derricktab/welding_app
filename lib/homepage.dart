import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:outline_search_bar/outline_search_bar.dart';
import 'constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

  @override
  Widget build(BuildContext context) {

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
                            xOffset = 210;
                            yOffset = 180;
                            scaleFactor = 0.65;
                            radius = 60;
                          });
                        },
                      ),
                actions: [
                  // CART ICON
                  IconButton(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    icon: const Icon(Icons.shopping_cart),
                    onPressed: () {
                      print("HELLO THERE USER");
                    },
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
              body: ListView(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 30),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40)),
                      color: primaryColor,
                    ),

                    // SEARCH BAR
                    child: OutlineSearchBar(
                      textEditingController: _textController,
                      borderRadius: BorderRadius.circular(25),
                      hintText: "Search Product",
                      elevation: 3,
                      clearButtonColor: Colors.black,
                      borderColor: Colors.black,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                    ),
                  ),
                  const SizedBox(height: 40),
      
                ],
              ),

              // BOTTOM NAVIGATION BAR
              bottomNavigationBar: BottomAppBar(
                // shape: const CircularNotchedRectangle(),
                // notchMargin: 6,
                color: primaryColor,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // HOME BUTTON
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isHome = true;
                            isServices = false;
                            isContact = false;
                          });
                        },
                        child: Row(
                          children: [
                            IconButton(
                                color: isHome ? activeColor : inactiveColor,
                                tooltip: "Homepage",
                                onPressed: () {
                                  setState(() {
                                    isHome = true;
                                    isServices = false;
                                    isContact = false;
                                  });
                                },
                                icon:
                                    const Icon(FontAwesomeIcons.houseChimney)),
                            Text(
                              "HOME",
                              style: TextStyle(
                                  color: isHome ? activeColor : inactiveColor),
                            ),
                          ],
                        ),
                      ),

                      // SERVICES BUTTON
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isHome = false;
                            isServices = true;
                            isContact = false;
                          });
                        },
                        child: Row(
                          children: [
                            IconButton(
                                color: isServices ? activeColor : inactiveColor,
                                tooltip: "Services",
                                onPressed: () {
                                  setState(() {
                                    isHome = false;
                                    isServices = true;
                                    isContact = false;
                                  });
                                },
                                icon: const Icon(FontAwesomeIcons.listCheck)),
                            Text(
                              "SERVICES",
                              style: TextStyle(
                                  color:
                                      isServices ? activeColor : inactiveColor),
                            ),
                          ],
                        ),
                      ),

                      // CONTACT BUTTON
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isHome = false;
                            isServices = false;
                            isContact = true;
                          });
                        },
                        child: Row(
                          children: [
                            IconButton(
                                color: isContact ? activeColor : inactiveColor,
                                tooltip: "Contact",
                                onPressed: () {
                                  setState(() {
                                    isHome = false;
                                    isServices = false;
                                    isContact = true;
                                  });
                                },
                                icon: const Icon(FontAwesomeIcons.phone)),
                            Text(
                              "CONTACT",
                              style: TextStyle(
                                  color:
                                      isContact ? activeColor : inactiveColor),
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
