import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? _username = "Loading.....";
  var _email;
  String? _phone = "Phone Not Set";
  String? _address = "Not Set";
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
      final query = FirebaseFirestore.instance
            .collection("users")
            .where("email", isEqualTo: _email.toString()).get().then((value) => print("Value: $value"));
      }
    });
  }

  // METHOD TO DISPLAY POPUP DIALOG BOX
  void _delete(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: const Text('Please Confirm'),
            content:
                const Text('Are You Sure You Want To Delete Your Account?'),
            actions: [
              // The "Yes" button
              TextButton(
                  onPressed: () async {
                    try {
                      await FirebaseAuth.instance.currentUser!.delete();
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'requires-recent-login') {
                        // Navigator.pop(context);
                        Navigator.pushNamed(context, "reauthenticate");
                      } else {
                        print("not this error");
                      }
                    }
                    // Remove the box

                    // Close the dialog
                    Navigator.of(context).pop();
                  },
                  child: const Text('Yes')),
              TextButton(
                  onPressed: () {
                    // Close the dialog
                    Navigator.of(context).pop();
                  },
                  child: const Text('No'))
            ],
          );
        });
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  void initState() {
    // TODO: implement initState
    Firebase.initializeApp();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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

            // PROFILE DETAILS

            // Name
            ListTile(
              title: Text(
                _username.toString(),
                style: const TextStyle(fontSize: 22),
              ),
              leading: const Icon(
                Icons.person,
                size: 35,
                color: Color.fromARGB(255, 14, 171, 22),
              ),
            ),
            const Divider(thickness: 2),

            // Email
            ListTile(
              title: Text(
                _email.toString(),
                style: const TextStyle(fontSize: 22),
              ),
              leading: const Icon(
                Icons.email_rounded,
                size: 35,
                color: Color.fromARGB(255, 14, 171, 22),
              ),
            ),
            const Divider(thickness: 2),

            // Phone Number
            ListTile(
              enabled: true,
              title: Text(
                _phone.toString(),
                style: const TextStyle(fontSize: 22),
              ),
              leading: const Icon(
                Icons.phone,
                size: 35,
                color: Color.fromARGB(255, 14, 171, 22),
              ),
            ),
            const Divider(thickness: 2),

            // Address
            ListTile(
              enabled: true,
              title: Text(
                _address.toString(),
                style: const TextStyle(fontSize: 22),
              ),
              leading: const Icon(
                Icons.location_on,
                size: 35,
                color: Color.fromARGB(255, 14, 171, 22),
              ),
            ),
            const Divider(thickness: 2),

            const SizedBox(height: 30),

            // edit profile button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
                onPressed: () {
                  Navigator.pushNamed(context, "edit_profile");
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 14),
                  child: Text(
                    "Edit Profile",
                    style: TextStyle(fontSize: 17),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            // Delete Account Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(), primary: Colors.red),
                onPressed: () {
                  // call the delete method to delete user
                  _delete(context);
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 14),
                  child: Text(
                    "Delete Account",
                    style: TextStyle(fontSize: 17),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Logout Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(), primary: Colors.orange),
                onPressed: () {
                  logout();
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 14),
                  child: Text(
                    "Logout",
                    style: TextStyle(fontSize: 19, color: Colors.black),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
