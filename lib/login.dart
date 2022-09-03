import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:welding_app/constants.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var _prefs;
  var _loggedIn = false;
  var _errorMessage;
// form key
  final _formKey = GlobalKey<FormState>();

// instatiating for the form input controllers
  var _email = TextEditingController();
  var _password = TextEditingController();

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
    // initialize firebase
    Firebase.initializeApp();
    setState(() {
      _prefs = SharedPreferences.getInstance();
    });
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
            "LOGIN",
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
                        return "Email Can't be empty";
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

                  // FORGOT PASSWORD BUTTON
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "forgot_password");
                    },
                    child: const Text(
                      "Forgot Password?",
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  // const SizedBox(height: 10),

                  // LOGIN BUTTON
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
                              .signInWithEmailAndPassword(
                            email: _email.text,
                            password: _password.text,
                          )
                              .then((value) {
                            print(value.user!.photoURL);
                          });
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            setState(() {
                              _errorMessage = "No user found for that email.";
                            });
                          } else if (e.code == 'wrong-password') {
                            setState(() {
                              _errorMessage =
                                  "Wrong password provided for that user.";
                            });
                          }
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
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                padding: EdgeInsets.all(20),
                                elevation: 8,
                                backgroundColor:
                                    Color.fromARGB(255, 221, 249, 196),
                                content: Text(
                                  "LOGIN SUCCESFULL",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                )),
                          );
                        }

                        Navigator.pop(context);
                        Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      primary: Colors.black,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 60, vertical: 15),
                    ),
                    child: const Text(
                      "LOGIN",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // LOGIN WITH GOOGLE
                  ElevatedButton.icon(
                    onPressed: () async {
                      // bring up the loader
                      Navigator.pushNamed(context, "loader");

                      signInWithGoogle().then((value) {
                        var user = value.user;
                        if (user != null) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text(
                              "Login Succesful",
                              textAlign: TextAlign.center,
                            ),
                            backgroundColor: Colors.green,
                            padding: EdgeInsets.symmetric(
                                vertical: 13, horizontal: 5),
                          ));
                          Navigator.pop(context);
                          Navigator.pop(context);
                          // Navigator.pop(context);
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Something Went Wrong"),
                            backgroundColor: Colors.red,
                            padding: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 15),
                          ));
                        }
                      });
                    },
                    icon: const Icon(
                      FontAwesomeIcons.google,
                      color: Colors.red,
                    ),
                    label: const Text(
                      "Signin With Google",
                      style: TextStyle(color: Colors.black),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      primary: const Color.fromARGB(244, 243, 239, 239),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                    ),
                  ),

                  // CREATE AN ACCOUNT
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Dont Have An Account Yet?",
                        style: TextStyle(color: Colors.white),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pushNamed(context, "signup");
                        },
                        child: const Text(
                          "Create Account",
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
