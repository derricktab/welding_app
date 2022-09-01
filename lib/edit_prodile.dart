import 'dart:io';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
          _nameField.text = user.displayName.toString();
          _username = user.displayName;
          _emailField.text = user.email.toString();
          _phoneField.text = user.phoneNumber.toString();
        });
      }
    });
  }

  uploadImage(var path) async {
    var imgName = DateTime.now();

    var storageRef =
        FirebaseStorage.instance.ref().child("userImages/$imgName.png");

    File file = File(path);
    try {
      await storageRef.putFile(file).then((p0) {
        print("Image Uploaded");
      }, onError: (error) {
        print(error.toString());
      });
    } catch (e) {
      // ...
      print(e);
    }
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
  var _addressField = TextEditingController();

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

                // EDIT ICON IMAGE
                const Positioned(
                    top: 135,
                    left: 125,
                    child: CircleAvatar(
                      backgroundColor: Color.fromARGB(191, 0, 0, 0),
                      radius: 65,
                      child: Icon(Icons.edit),
                    )),

                Container(
                  height: 300,
                )
              ],
            ),

            // const Divider(thickness: 2),

            // NAME TEXT FIELD
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                decoration: const InputDecoration(
                    hintText: "Enter Name",
                    prefixIcon: Icon(Icons.person),
                    prefixIconColor: Colors.red,
                    border: OutlineInputBorder()),
                controller: _nameField,

                // checking if the input field is not null
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Name Cant Be Empty";
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 10),

            // EMAIL TEXT FIELD
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                decoration: const InputDecoration(
                    hintText: "Enter Email",
                    prefixIcon: Icon(Icons.email),
                    prefixIconColor: Colors.red,
                    border: OutlineInputBorder()),
                controller: _emailField,

                // checking if the input field is not null
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Email Cant Be Empty";
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 10),

            // PHONE TEXT FIELD
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                decoration: const InputDecoration(
                    hintText: "Enter Phone Number",
                    prefixIcon: Icon(Icons.phone),
                    prefixIconColor: Colors.red,
                    border: OutlineInputBorder()),
                controller: _phoneField,

                // checking if the input field is not null
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Phone Cant Be Empty";
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 10),

            // ADDRESS TEXT FIELD
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                decoration: const InputDecoration(
                    hintText: "Enter Address",
                    prefixIcon: Icon(Icons.location_on_outlined),
                    prefixIconColor: Colors.red,
                    border: OutlineInputBorder()),
                controller: _addressField,

                // checking if the input field is not null
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Address Cant Be Empty";
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 30),

            // SAVE BUTTON
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
                onPressed: () {
                  if (_form.currentState!.validate()) {
                    print("VALIDATED");
                  }
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 14),
                  child: Text(
                    "SAVE",
                    style: TextStyle(fontSize: 20),
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
