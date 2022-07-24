import 'package:flutter/material.dart';
import 'package:welding_app/product.dart';

class SingleProduct extends StatelessWidget {
  String img;
  String prodName;
  String price;

  SingleProduct({
    Key? key,
    required this.img,
    required this.prodName,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 149, 151, 147),
              blurRadius: 8,
              spreadRadius: 0.02,
              offset: Offset.fromDirection(0),
            ),
          ],
        ),
        child: ListView(
          children: [
            // // PRODUCT IMAGE
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30)),
              child: Image.asset(
                img,
                height: 120,
                width: 170,
                scale: 0.0001,
              ),
            ),
            const SizedBox(height: 13),

            // PRODUCT NAME
            Text(
              prodName,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 10),

            // PRODUCT PRICE
            Text(
              "~ UGX: " + price,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Product()));
      },
    );
  }
}
