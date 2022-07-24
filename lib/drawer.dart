import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:welding_app/constants.dart';
import 'package:share_plus/share_plus.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  shareTheApp() async {
    await Share.share("Invention Plus Group Of Companies");
  }



  @override
  void initState() {
    // initializing firebase app
    Firebase.initializeApp();

    // // checking if the user is logged in
    // FirebaseAuth.instance.authStateChanges().listen((User? user) {
    //   if (user != null) {
    //     setState(() {
    //       _loggedIn = true;
    //     });
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 255, 255, 255),
            Color.fromARGB(255, 244, 249, 245),
            Color.fromARGB(255, 240, 249, 242),
            primaryColor,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        )),
        padding: const EdgeInsets.only(left: 6),
        // color: Colors.lime,
        child: ListView(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 30, left: 15),
              child: Row(
                children: const [
                  Text(
                    "INVENTION PLUS",
                    style: TextStyle(
                      letterSpacing: 1,
                      fontFamily: "times new roman",
                      fontSize: 27,
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 70),
              child: const Text(
                "GROUP OF COMPANIES LTD",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(
              height: 80,
            ),
            ListTile(
              leading: const Icon(
                FontAwesomeIcons.house,
                size: 30,
                color: primaryColor,
              ),
              title: const Text("Home",
                  style: TextStyle(
                    fontSize: 20,
                    color: primaryColor,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.5,
                  )),
              onTap: () {
                setState(() {});
              },
            ),

            // INFO TILE
            ListTile(
              leading: const Icon(
                Icons.line_style_rounded,
                size: 35,
                color: Colors.black,
              ),
              title: const Text(
                "Services",
                style: TextStyle(
                  fontSize: 19,
                  color: Colors.black,
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, "services");
              },
            ),

            // NEARBY DOCTOR TILE
            ListTile(
              leading: const Icon(
                FontAwesomeIcons.vanShuttle,
                size: 30,
                color: Colors.black,
              ),
              title: const Text(
                "Orders",
                style: TextStyle(
                  fontSize: 19,
                  color: Colors.black,
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, "orders");
              },
            ),

            // FAQ TILE
            ListTile(
              leading: const Icon(
                FontAwesomeIcons.phone,
                size: 30,
                color: Colors.black,
              ),
              title: const Text(
                "Contact Us",
                style: TextStyle(
                  fontSize: 19,
                  color: Colors.black,
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, "contact");
              },
            ),

            // ABOUT TILE
            ListTile(
              leading: const Icon(
                FontAwesomeIcons.circleInfo,
                size: 30,
                color: Colors.black,
              ),
              title: const Text(
                "About Us",
                style: TextStyle(
                  fontSize: 19,
                  color: Colors.black,
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, "about");
              },
            ),

            // SHARE TILE
            ListTile(
              leading: const Icon(
                FontAwesomeIcons.shareFromSquare,
                size: 30,
                color: Colors.black,
              ),
              title: const Text(
                "Share",
                style: TextStyle(
                  fontSize: 19,
                  color: Colors.black,
                ),
              ),
              onTap: () {
                shareTheApp();
              },
            ),

            const SizedBox(
              height: 150,
            ),

            ListTile(
              leading: const Icon(
                FontAwesomeIcons.powerOff,
                size: 30,
                color: Colors.red,
              ),
              title: const Text(
                "Login",
                style: TextStyle(
                  fontSize: 19,
                  color: Colors.white,
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, "login");
              },
            ),
          ],
        ),
      ),
    );
  }
}
