import 'package:flutter/material.dart';
import 'package:welding_app/product.dart';

class SingleProduct extends StatelessWidget {
  String img;
  String prodName;
  String price;
  String prodId;

  SingleProduct({
    Key? key,
    required this.img,
    required this.prodName,
    required this.price,
    required this.prodId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 179, 180, 178),
              blurRadius: 8,
              spreadRadius: 0.02,
              offset: Offset.fromDirection(0),
            ),
          ],
        ),
        child: Column(
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
              textAlign: TextAlign.start,
              style: const TextStyle(
                  fontSize: 17, color: Color.fromARGB(255, 63, 62, 62)),
            ),
            const SizedBox(height: 8),

            // PRODUCT PRICE
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                "~ UGX: " + price,
                style: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Product(prodId: prodId,)));
      },
    );
  }
}
