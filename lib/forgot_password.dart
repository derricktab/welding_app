import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:welding_app/constants.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  var _formKey = GlobalKey<FormState>();
  var _email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Forgot Password"),
        backgroundColor: primaryColor,
      ),
      body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _email,
                  decoration: const InputDecoration(
                      hintText: "Enter Your Email",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)))),
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(primaryColor)),
                    onPressed: () {
                      Navigator.pushNamed(context, "loader");
                      var email = _email.text;
                      FirebaseAuth.instance
                          .sendPasswordResetEmail(email: email)
                          .then((value) {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: Colors.green,
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 5),
                            content: Text(
                                "Password Reset Email Sent, Please Check Your Email To Reset Your Password."),
                          ),
                        );
                        print("PASSWORD RESET EMAIL SENT");
                      }, onError: (error) {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: Colors.red,
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 5),
                            content: Text("Something Went Wrong"),
                          ),
                        );
                        print("SOMETHING WENT WRONG");
                      });
                    },
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                      child: Text(
                        "RESET PASSWORD",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ))
              ],
            ),
          )),
    );
  }
}
