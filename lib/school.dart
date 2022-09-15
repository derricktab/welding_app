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
          children: const [
            SizedBox(
              height: 100,
              child: Center(
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
            Text("INVENTION PLUS JUNIOR SCHOOL"),
          ],
        ));
  }
}
