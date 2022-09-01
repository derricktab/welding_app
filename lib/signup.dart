import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:welding_app/constants.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var _loggedIn = false;
  var _errorMessage;
  // form key
  final _formKey = GlobalKey<FormState>();

  // instatiating for the form input controllers
  var _name = TextEditingController();
  var _email = TextEditingController();
  var _password = TextEditingController();
  var _phone = TextEditingController();
  var _address = TextEditingController();
  var _confirmPassword = TextEditingController();

  // hiding password input
  var _obscureText = true;

  OutlineInputBorder myinputborder() {
    return const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(
          color: Colors.white,
          width: 2,
        ));
  }

  OutlineInputBorder myfocusborder() {
    return const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(
          color: Color.fromARGB(255, 243, 243, 243),
          width: 3,
        ));
  }

  // SIGNIN WITH GOOGLE METHOD
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  void initState() {
    // initializating the firebase app
    Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.chevron_left,
              size: 40,
            )),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: ListView(
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // UPPER SECTION
          ClipPath(
            clipper: BottomWaveClipper(),
            child: Container(
              color: Colors.white,
              width: double.infinity,
              height: 260,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 60),
                child: Image.asset(
                  "assets/images/L1.png",
                  width: 250,
                ),
              ),
            ),
          ),
          const Text(
            "SIGN UP",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontFamily: "times new roman",
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),

          // LOWER SECTION
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  // NAME FORM FIELD
                  TextFormField(
                    style: const TextStyle(color: Colors.white),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Name Can't be empty";
                      }
                      return null;
                    },
                    scrollPadding: const EdgeInsets.all(5),
                    controller: _name,
                    decoration: InputDecoration(
                      enabledBorder: myinputborder(),
                      label: const Text(
                        "Full Name: ",
                        style: TextStyle(color: Colors.white),
                      ),
                      hintText: "Enter Your Name",
                      prefixIcon: const Icon(
                        Icons.person,
                        color: Colors.amberAccent,
                      ),
                      border: myinputborder(),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // EMAIL FORM FIELD
                  TextFormField(
                    style: const TextStyle(color: Colors.white),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "EMAIL Can't be empty";
                      }
                      return null;
                    },
                    scrollPadding: const EdgeInsets.all(5),
                    controller: _email,
                    decoration: InputDecoration(
                      enabledBorder: myinputborder(),
                      label: const Text(
                        "Email: ",
                        style: TextStyle(color: Colors.white),
                      ),
                      hintText: "Enter Email",
                      prefixIcon: const Icon(
                        Icons.email,
                        color: Colors.amberAccent,
                      ),
                      border: myinputborder(),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // PHONE FORM FIELD
                  TextFormField(
                    style: const TextStyle(color: Colors.white),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "PHONE Can't be empty";
                      }
                      return null;
                    },
                    scrollPadding: const EdgeInsets.all(5),
                    controller: _phone,
                    decoration: InputDecoration(
                      enabledBorder: myinputborder(),
                      label: const Text(
                        "Phone Number: ",
                        style: TextStyle(color: Colors.white),
                      ),
                      hintText: "Enter Username",
                      prefixIcon: const Icon(
                        Icons.phone,
                        color: Colors.amberAccent,
                      ),
                      border: myinputborder(),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // ADDRESS INPUT FIELD
                  TextFormField(
                    style: const TextStyle(color: Colors.white),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Address Can't be empty";
                      }
                      return null;
                    },
                    scrollPadding: const EdgeInsets.all(5),
                    controller: _address,
                    decoration: InputDecoration(
                      enabledBorder: myinputborder(),
                      label: const Text(
                        "Address: ",
                        style: TextStyle(color: Colors.white),
                      ),
                      hintText: "Enter Your Address",
                      prefixIcon: const Icon(
                        Icons.location_on,
                        color: Colors.amberAccent,
                      ),
                      border: myinputborder(),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // PASSWORD FORM FIELD
                  TextFormField(
                    style: const TextStyle(color: Colors.white),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Password Can't be empty";
                      }
                      return null;
                    },
                    controller: _password,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      suffixIcon: _obscureText
                          ? IconButton(
                              padding: const EdgeInsets.all(0),
                              icon: const Icon(
                                Icons.remove_red_eye_outlined,
                                color: Colors.amber,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                            )
                          : IconButton(
                              padding: const EdgeInsets.all(0),
                              onPressed: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                              icon: const Icon(Icons.shield_rounded),
                              color: Colors.amber,
                            ),
                      label: const Text(
                        "Password: ",
                        style: TextStyle(color: Colors.white),
                      ),
                      prefixIcon: const Icon(
                        Icons.lock,
                        color: Colors.amberAccent,
                      ),
                      border: myinputborder(),
                      enabledBorder: myinputborder(),
                    ),
                  ),

                  const SizedBox(height: 10),
                  // CONFIRM PASSWORD FORM FIELD
                  TextFormField(
                    style: const TextStyle(color: Colors.white),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Confirm Password Can't be empty";
                      }
                      return null;
                    },
                    controller: _confirmPassword,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      suffixIcon: _obscureText
                          ? IconButton(
                              padding: const EdgeInsets.all(0),
                              icon: const Icon(
                                Icons.remove_red_eye_outlined,
                                color: Colors.amber,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                            )
                          : IconButton(
                              padding: const EdgeInsets.all(0),
                              onPressed: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                              icon: const Icon(Icons.shield_rounded),
                              color: Colors.amber,
                            ),
                      label: const Text(
                        "Confirm Password: ",
                        style: TextStyle(color: Colors.white),
                      ),
                      prefixIcon: const Icon(
                        Icons.lock,
                        color: Colors.amberAccent,
                      ),
                      border: myinputborder(),
                      enabledBorder: myinputborder(),
                    ),
                  ),
                  const SizedBox(height: 15),

                  //
                  // SIGNUP BUTTON
                  ElevatedButton(
                    onPressed: () async {
                      // displaying the loader
                      Navigator.pushNamed(context, "loader");

                      setState(() {
                        _errorMessage = null;
                      });

                      if (_formKey.currentState!.validate()) {
                        try {
                          final credential = await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                            email: _email.text,
                            password: _password.text,
                          );
                          print("user created");
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            setState(() {
                              _errorMessage =
                                  'The password provided is too weak.';
                            });
                          } else if (e.code == 'email-already-in-use') {
                            setState(() {
                              _errorMessage =
                                  'A User with that email already exists';
                            });
                          }
                        } catch (e) {
                          setState(() {
                            _errorMessage = e;
                          });
                        }

                        Navigator.pop(context);

                        if (_errorMessage != null) {
                          // if an error occurs
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                padding: EdgeInsets.all(20),
                                elevation: 8,
                                backgroundColor: Colors.red,
                                content: Text(
                                  _errorMessage,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                )),
                          );
                        } else {

                        // if registration is successful
                          var _user = {
                            "name": _name.text,
                            "email": _email.text,
                            "phone": _phone.text,
                            "address": _address.text,
                            "role": "user",
                            "image": "assets/images/user.png",
                          };

                          FirebaseFirestore.instance
                              .collection("users")
                              .add(_user)
                              .then((value) {
                            print("Data added to Cloud Firestore");
                          });

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                padding: EdgeInsets.all(20),
                                elevation: 8,
                                backgroundColor:
                                    Color.fromARGB(255, 221, 249, 196),
                                content: Text(
                                  "REGISTRATION SUCCESFULL",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                )),
                          );

                          // saving the user profile details
                          FirebaseAuth.instance.authStateChanges().listen(
                            (User? user) async {
                              if (user != null) {
                                await user.updateDisplayName(_name.text);
                                await user.sendEmailVerification();
                              }
                            },
                          );
                        }

                        Navigator.pop(context);
                        Navigator.pushNamed(context, "profile");
                        FirebaseAuth.instance
                            .authStateChanges()
                            .listen((User? user) {
                          if (user != null) {
                            setState(() {
                              _loggedIn = true;
                            });
                          }
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      primary: Colors.black,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 60, vertical: 15),
                    ),
                    child: const Text(
                      "SIGN UP",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // LOGIN WITH GOOGLE
                  ElevatedButton.icon(
                    onPressed: () {
                      final user = signInWithGoogle();
                      FirebaseAuth.instance
                          .authStateChanges()
                          .listen((User? user) {
                        if (user != null) {
                          setState(() {
                            Navigator.pop(context);
                            Navigator.pushNamed(context, "profile");
                            _loggedIn = true;
                          });
                        }
                      });
                    },
                    icon: const Icon(
                      FontAwesomeIcons.google,
                      color: Colors.red,
                    ),
                    label: const Text(
                      "Login With Google",
                      style: TextStyle(color: Colors.black),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      primary: Color.fromARGB(244, 243, 239, 239),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                    ),
                  ),

                  // CREATE AN ACCOUNT
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already Have An Account?",
                        style: TextStyle(color: Colors.white),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pushNamed(context, "login");
                        },
                        child: const Text(
                          "Login",
                          style: TextStyle(
                            color: Colors.yellow,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - 40);
    path.quadraticBezierTo(
        size.width / 4, size.height - 80, size.width / 2, size.height - 40);
    path.quadraticBezierTo(size.width - (size.width / 4), size.height,
        size.width, size.height - 40);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
