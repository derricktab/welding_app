import 'package:flutter/material.dart';
import 'package:welding_app/constants.dart';

import 'myappbar.dart';

class About extends StatefulWidget {
  const About({Key? key}) : super(key: key);

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.chevron_left,
              size: 38,
            )),
        backgroundColor: primaryColor,
        elevation: 0,
      ),
      body: ListView(children: [
        Container(
          decoration: const BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(80),
                  bottomRight: Radius.circular(80))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 25),
              const Text(
                "ABOUT US",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: "times",
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              ),

              // LINE
              Container(
                margin: const EdgeInsets.only(top: 10, bottom: 20),
                height: 5,
                width: 70,
                color: Colors.yellow,
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),

        // LOGO
        Image.asset("assets/images/logo2.png", height: 200),

        // ABOUT US TEXT
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 40),
          child: Text(
            "Invention Plus Group of Companies is a registered company with 10 plus + years of experience in Metal production manufacturing and maintenance services. Our management concept is founded on professionalism, accountability, and quality service that guarantees the maximum return from the investment while maintaining your property at the highest standard.\n\n We are located in Nsangi Manja Zone, Uganda. ",
            style: TextStyle(fontSize: 18),
          ),
        ),

        // CONTACT US BUTTON
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.red,
              shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () async {
              Navigator.pop(context);
              Navigator.pushNamed(context, "contact");
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 15.0),
              child: Text("CONTACT US"),
            ),
          ),
        ),
        const SizedBox(height: 20),
      ]),
    );
  }
}
