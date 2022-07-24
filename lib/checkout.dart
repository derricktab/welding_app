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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/success.png"),
          const SizedBox(height: 20),
          const Text("Your Order Has Been Placed Successfully."),
        ],
      ),
    );
  }
}
