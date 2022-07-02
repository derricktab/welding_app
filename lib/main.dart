import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
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

  // NATIVE SPLASH
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
    @override
  void initState() {
    super.initState();
    initialization();
  }

  void initialization() async {
    // This is where you can initialize the resources needed by your app while
    // the splash screen is displayed.  Remove the following example because
    // delaying the user experience is a bad design practice!
    // ignore_for_file: avoid_print
    print('ready in 3...');
    await Future.delayed(const Duration(seconds: 1));
    print('ready in 2...');
    await Future.delayed(const Duration(seconds: 1));
    print('ready in 1...');
    await Future.delayed(const Duration(seconds: 1));
    print('go!');
    FlutterNativeSplash.remove();
  }
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
