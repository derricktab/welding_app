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
        appBar: AppBar(
          backgroundColor: primaryColor,
          elevation: 0,
        ),
        body: ListView(
          children: [
            Container(
              color: primaryColor,
              height: 100,
              child: const Center(
                child: Text(
                  "INVENTION PLUS JUNIOR SCHOOL",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      fontFamily: "times new roman"),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const Text("INVENTION PLUS JUNIOR SCHOOL"),
          ],
        ));
  }
}
