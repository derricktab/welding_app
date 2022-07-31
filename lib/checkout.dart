import 'package:flutter/material.dart';

import 'constants.dart';

class CheckOut extends StatefulWidget {
  const CheckOut({Key? key}) : super(key: key);

  @override
  State<CheckOut> createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
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
        title: const Text("CHECKOUT"),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body: ListView(
        children: [
          const SizedBox(height: 100),
          Image.asset(
            "assets/images/success.png",
            height: 250,
          ),

          // SUCCESS MESSAGE
          const SizedBox(height: 40),
          const Padding(
            padding: EdgeInsets.all(25),
            child: Text(
              "SUCCESS",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // CONFIRMATION MESSAGE
          // const SizedBox(height: 5),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            child: Text(
              "Your Order Has Been Placed Successfully. We shall Contact You Soon for More Details.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontFamily: "times",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
