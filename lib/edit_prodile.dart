import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String? _username = "Loading.....";
  var _email;
  String? _phone = "Phone Not Set";
  var _isShown;

// METHOD TO GET THE USER DATA
  getUserData() {
    final components =
        FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        setState(() {
          _username = user.displayName;
          _email = user.email;
          _phone = user.phoneNumber;
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    Firebase.initializeApp();
    getUserData();
  }

  final _form = GlobalKey<FormState>();
  var _nameField = TextEditingController();
  var _emailField = TextEditingController();
  var _phoneField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _form,
        child: ListView(
          children: [
            // STACK TO CONTAIN THE PROFILE DETAILS
            Stack(
              children: [
                // UPPER AREA
                Container(
                  height: 200,
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.black,
                            Colors.green,
                            Colors.greenAccent,
                          ]),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(60),
                          bottomRight: Radius.circular(60))),
                  child: Column(
                    children: [
                      // BACK ARROW
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 5.0, vertical: 12),
                                child: Icon(
                                  Icons.arrow_back_ios_new,
                                  color: Colors.white,
                                ),
                              ))
                        ],
                      ),
                      const SizedBox(height: 27),
                      // DISPLAYING LOGGEDIN USERNAME
                      Center(
                          child: Text(
                        _username!.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 247, 245, 245),
                        ),
                      )),
                    ],
                  ),
                ),

                // PROFILE IMAGE
                const Positioned(
                  top: 135,
                  left: 125,
                  child: CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 139, 188, 234),
                    radius: 65,
                    backgroundImage: AssetImage(
                      "assets/images/dummy-user.png",
                    ),
                  ),
                ),

                Container(
                  height: 300,
                )
              ],
            ),

            const Divider(thickness: 2),

            const SizedBox(height: 40),

            // SAVE BUTTON
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
                onPressed: () {},
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 14),
                  child: Text(
                    "Save",
                    style: TextStyle(fontSize: 17),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
