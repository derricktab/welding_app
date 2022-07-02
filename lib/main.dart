import 'package:flutter/material.dart';
import 'package:welding_app/about.dart';
import 'package:welding_app/contact.dart';
import 'package:welding_app/drawer.dart';
import 'package:welding_app/homepage.dart';
import 'package:welding_app/initial_screen.dart';
import 'package:welding_app/loader.dart';
import 'package:welding_app/login.dart';
import 'package:welding_app/orders.dart';
import 'package:welding_app/services.dart';
import 'package:welding_app/signup.dart';
import 'profile.dart';

void main(List<String> args) {
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "home": (context) => const HomePage(),
        "drawer": (context) => const Drawer(),
        "login": (context) => const Login(),
        "signup": (context) => const SignUp(),
        "profile": (context) => const Profile(),
        "contact": (context) => const Contact(),
        "services": (context) => const Services(),
        "loader": (context) => const MyLoader(),
        "reauthenticate": (context) => const MyLoader(),
        "about": (context) => const About(),
        "orders": (context) => const Orders(),
        "initial_screen": (context) => const InitialScreen(),
      },
      home: Stack(
        children: const [
          DrawerScreen(),
          HomePage(),
        ],
      ),
    );
  }
}
