import 'package:flutter/material.dart';

class School extends StatefulWidget {
  const School({super.key});

  @override
  State<School> createState() => _SchoolState();
}

class _SchoolState extends State<School> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(children: const [Text("INVENTION PLUS JUNIOR SCHOOL"),],)
    );
  }
}
