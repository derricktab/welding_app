import 'package:flutter/material.dart';
import 'package:welding_app/constants.dart';

import 'myappbar.dart';

class About extends StatefulWidget {
  const About({Key? key}) : super(key: key);

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About Us"),
        backgroundColor: primaryColor,
      ),
    );
  }
}
