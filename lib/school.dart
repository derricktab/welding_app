import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:welding_app/constants.dart';

class School extends StatefulWidget {
  const School({super.key});

  @override
  State<School> createState() => _SchoolState();
}

class _SchoolState extends State<School> {
  var imgList = [
    "assets/images/school1.jpeg",
    "assets/images/school2.jpeg",
    "assets/images/school3.jpeg",
    "assets/images/school4.jpeg",
  ];

  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
// IMAGE SLIDERS
    final List<Widget> imageSliders = imgList
        .map((item) => Container(
              margin: const EdgeInsets.all(5.0),
              // height: 600,
              child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                  child: Image.asset(
                    item,
                    height: 800,
                    width: 700,
                  )),
            ))
        .toList();
    return Scaffold(
        backgroundColor: primaryColor,
        appBar: AppBar(
          backgroundColor: primaryColor,
          elevation: 0,
        ),
        body: ListView(
          children: [
            SizedBox(
              height: 160,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/bts-removebg-preview.png"),
                  const Expanded(
                    child: Text(
                      "INVENTION PLUS JUNIOR SCHOOL",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          fontFamily: "times new roman"),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.yellow,
                      blurRadius: 5,
                      offset: Offset.fromDirection(2))
                ],
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(35),
                    topLeft: Radius.circular(35)),
                color: Colors.white,
              ),
              // height: 700,
              child: Column(
                children: [
                  // Image Slider
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

                  // Slider Dots
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
                  const SizedBox(height: 10),

                  // LOCATION
                  Container(
                    margin:
                        const EdgeInsets.only(bottom: 10, right: 15, left: 15),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.red,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Icon(
                          FontAwesomeIcons.locationCrosshairs,
                          color: Colors.lightGreenAccent,
                        ),
                        Text(
                          "1KM Along Nsangi Buloba Road",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // ACTIVITIES
                  Container(
                    margin:
                        const EdgeInsets.only(bottom: 5, right: 15, left: 15),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: primaryColor,
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: const [
                            SizedBox(width: 20),
                            Icon(
                              FontAwesomeIcons.chevronRight,
                              color: Colors.lightGreenAccent,
                              size: 16,
                            ),
                            SizedBox(width: 15),
                            Text(
                              "We Offer Theology & Secular Studies",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: const [
                            SizedBox(width: 20),
                            Icon(
                              FontAwesomeIcons.chevronRight,
                              color: Colors.lightGreenAccent,
                              size: 16,
                            ),
                            SizedBox(width: 15),
                            Text(
                              "Commited Staff",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: const [
                            SizedBox(width: 20),
                            Icon(
                              FontAwesomeIcons.chevronRight,
                              color: Colors.lightGreenAccent,
                              size: 16,
                            ),
                            SizedBox(width: 15),
                            Text(
                              "Excellent Teacher-Student Ratio",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: const [
                            SizedBox(width: 20),
                            Icon(
                              FontAwesomeIcons.chevronRight,
                              color: Colors.lightGreenAccent,
                              size: 16,
                            ),
                            SizedBox(width: 15),
                            Text(
                              "Affordable School Fees",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: const [
                            SizedBox(width: 20),
                            Icon(
                              FontAwesomeIcons.chevronRight,
                              color: Colors.lightGreenAccent,
                              size: 16,
                            ),
                            SizedBox(width: 15),
                            Text(
                              "Computer Studies/Lessons",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: const [
                            SizedBox(width: 20),
                            Icon(
                              FontAwesomeIcons.chevronRight,
                              color: Colors.lightGreenAccent,
                              size: 16,
                            ),
                            SizedBox(width: 15),
                            Text(
                              "Well Balanced Alternate Menu",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
