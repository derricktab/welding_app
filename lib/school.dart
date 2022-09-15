import 'package:flutter/material.dart';
import 'package:welding_app/constants.dart';

class School extends StatefulWidget {
  const School({super.key});

  @override
  State<School> createState() => _SchoolState();
}

class _SchoolState extends State<School> {
  @override
  Widget build(BuildContext context) {
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
              height: 700,
              child: const Text("INVENTION PLUS JUNIOR SCHOOL"),
            ),
          ],
        ));
  }
}
