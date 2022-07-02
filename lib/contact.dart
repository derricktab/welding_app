// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:welding_app/constants.dart';

class Contact extends StatefulWidget {
  const Contact({Key? key}) : super(key: key);

  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  static const int pink = 0xFFeb406a;

  final TextEditingController _fullname = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _message = TextEditingController();
  final _contactForm = GlobalKey<FormState>();

  String userEmail = "";
  String userMessage = "";
  String userFullName = "";

// DISPLAYING A POP ON SUCCESFULLY SENDING MESSAGE
  _displayDialog(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: const [
              Icon(
                FontAwesomeIcons.checkToSlot,
                color: Colors.green,
              ),
              SizedBox(width: 16),
              Text('SUCCESS'),
            ],
          ),
          content: const Text('MESSAGE SENT SUCCESFULLY'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("OK"),
            )
          ],
        );
      },
    );
  }

// Function to send the message to cloud firestore
  // void sendMessage() async {
  //   var fbCollection = FirebaseFirestore.instance.collection("messages");

  //   var result = await fbCollection.add({
  //     'message': userMessage,
  //     'email': userEmail,
  //     'fullname': userFullName
  //   }).then((value) => _displayDialog(context));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // resizeToAvoidBottomPadding: false,
      appBar: AppBar(
          backgroundColor: primaryColor,
          elevation: 0,
          title: const Text(
            "Contact Us",
            style: TextStyle(fontSize: 22),
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: Icon(Icons.ac_unit),
            ),
          ]),
      body: Container(
        color: const Color.fromARGB(17, 15, 197, 243),
        height: double.infinity,
        child:
            Stack(fit: StackFit.loose, clipBehavior: Clip.antiAlias, children: [
          ListView(
            children: [
              Container(
                  height: 380,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(24),
                        bottomRight: Radius.circular(24)),
                    color: primaryColor,
                  ),
                  child: ListView(
                    children: [
                      Image.asset(
                        "assets/images/contact.png",
                        width: 120,
                        height: 220,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child:
                                              Icon(FontAwesomeIcons.envelope),
                                        )),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),

                                      // Email Column
                                      child: Column(
                                        children: const [
                                          Padding(
                                            padding: EdgeInsets.only(bottom: 5),
                                            child: Text(
                                              "Email",
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            "info@inventionplus.com",
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 245, 240, 240),
                                                fontSize: 14),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),

                            // Phone Column
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                        decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),

                                        // Phone Icon
                                        child: const Padding(
                                          padding: EdgeInsets.all(7.0),
                                          child: Icon(FontAwesomeIcons.phone),
                                        )),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: Column(
                                        children: const [
                                          Padding(
                                            padding: EdgeInsets.only(bottom: 7),
                                            child: Text(
                                              "Phone",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 17,
                                                  color: Colors.white),
                                            ),
                                          ),
                                          Text(
                                            "+256772438981",
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    239, 255, 255, 255)),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  )),
            ],
          ),

          // FORM TO CAPTURE THE RESPONSE
          Positioned(
            bottom: 25,
            left: 35,
            right: 35,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white,
              ),
              height: 335,

              // CONTACT FORM
              child: Form(
                  key: _contactForm,
                  child: ListView(
                    children: [
                      // FULL NAME INPUT BOX
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 15, top: 20, right: 15),
                        child: TextFormField(
                          controller: _fullname,
                          keyboardType: TextInputType.name,
                          decoration: const InputDecoration(
                            label: Text("Full Name"),
                            hintText: "Full Name",
                            suffixIcon: Icon(Icons.person),
                          ),
                        ),
                      ),

                      // EMAIL INPUT BOX
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 5),
                        child: TextFormField(
                          controller: _email,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                              label: Text("Email"),
                              hintText: "Email",
                              suffixIcon: Icon(FontAwesomeIcons.envelope)),
                        ),
                      ),

                      // MESSAGE INPUT BOX
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: TextFormField(
                          controller: _message,
                          keyboardType: TextInputType.text,
                          maxLines: 2,
                          decoration:
                              const InputDecoration(label: Text("Message")),
                        ),
                      ),

                      // SEND BUTTON
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 30),
                        child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(primaryColor),
                            ),
                            onPressed: () {
                              setState(() {
                                userFullName = _fullname.text;
                                userEmail = _email.text;
                                userMessage = _message.text;
                              });
                              // sendMessage();
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text("Send",
                                      style: TextStyle(
                                        fontSize: 21,
                                      )),
                                  SizedBox(width: 10),
                                  Icon(Icons.send)
                                ],
                              ),
                            )),
                      )
                    ],
                  )),
            ),
          ),
        ]),
      ),
    );
  }
}
