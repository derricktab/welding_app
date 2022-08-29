import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:is_first_run/is_first_run.dart';
import 'package:welding_app/about.dart';
import 'package:welding_app/cart.dart';
import 'package:welding_app/checkout.dart';
import 'package:welding_app/contact.dart';
import 'package:welding_app/drawer.dart';
import 'package:welding_app/finished_projects.dart';
import 'package:welding_app/homepage.dart';
import 'package:welding_app/loader.dart';
import 'package:welding_app/login.dart';
import 'package:welding_app/new.dart';
import 'package:welding_app/ongoing_projects.dart';
import 'package:welding_app/orders.dart';
// import 'package:welding_app/product.dart';
import 'package:welding_app/services.dart';
import 'package:welding_app/signup.dart';
import 'profile.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(const MainApp());
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
        "cart": (context) => const Cart(),
        "checkout": (context) => const CheckOut(),
        "finished_projects": (context) => const FinishedProjects(),
        "ongoing_projects": (context) => const OngoingProjects(),
        "gallery": (context) => MyApp(),
      },
      home: AnimatedSplashScreen(
        splashIconSize: 180,
        splash: 'assets/images/L1.png',
        nextScreen: Stack(
          children: const [
            DrawerScreen(),
            HomePage(),
          ],
        ),
        splashTransition: SplashTransition.scaleTransition,
        // pageTransitionType: PageTransitionType.scale,
      ),
    );
  }
}
