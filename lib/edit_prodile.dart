import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String? _username = "Loading.....";
  var _email;
  String? _phone = "Phone Not Set";
  var _userImage =
      "https://firebasestorage.googleapis.com/v0/b/invention-plus.appspot.com/o/user.png?alt=media&token=e0070a00-a874-49ac-975c-c327d8779ed3";
  var _uid;

  // Get User ID
  getUid() {
    var uid = FirebaseAuth.instance.currentUser!.uid;
    // get latest id
    return uid;
  }

// METHOD TO GET THE USER DATA
  getUserData() async {
    var uid = await getUid();
    setState(() {
      _uid = uid;
    });
    final components =
        FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user != null) {
        FirebaseFirestore.instance
            .collection("users")
            .doc(uid)
            .get()
            .then((value) {
          setState(() {
            _nameField.text = value["name"];
            _username = value["name"];
            _emailField.text = value["email"];
            _addressField.text = value["address"];
            _phoneField.text = value["phone"];
            _userImage = value["image"];
          });
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
      await storageRef.putFile(file).then((p0) async {
        var imgUrl = await storageRef.getDownloadURL();
        print(imgUrl);
        setState(() {
          _userImage = imgUrl;
        });
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
  var _path;

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
                Positioned(
                  top: 135,
                  left: 125,
                  child: CircleAvatar(
                    backgroundColor: const Color.fromARGB(255, 139, 188, 234),
                    radius: 65,
                    backgroundImage: NetworkImage(
                      _userImage,
                    ),
                  ),
                ),

                // EDIT ICON IMAGE
                Positioned(
                    top: 135,
                    left: 125,
                    child: GestureDetector(
                      onTap: () async {
                        var image = await ImagePicker()
                            .pickImage(source: ImageSource.gallery);
                        setState(() {
                          _path = image!.path;
                        });
                        await uploadImage(_path);
                      },
                      child: const CircleAvatar(
                        backgroundColor: Color.fromARGB(135, 0, 0, 0),
                        radius: 65,
                        child: Icon(
                          Icons.camera_alt_sharp,
                          color: Colors.white,
                          size: 35,
                        ),
                      ),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
                  onPressed: () {
                    if (_form.currentState!.validate()) {
                      FirebaseFirestore.instance
                          .collection("users")
                          .doc(_uid)
                          .update(
                        {
                          "image": _userImage.toString(),
                          "name": _nameField.text.toString(),
                          "email": _emailField.text.toString(),
                          "phone": _phoneField.text.toString(),
                          "address": _addressField.text.toString(),
                        },
                      ).then((value) {
                        print("DATA UPDATED SUCCESFULLY");
                      });
                      // print("VALIDATED");
                    }
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                    child: Text(
                      "SAVE",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),

                // CANCEL BUTTON
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(), primary: Colors.black),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 14, horizontal: 5),
                    child: Text(
                      "CANCEL",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
