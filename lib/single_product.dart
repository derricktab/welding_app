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
        height: 300,
        width: 150,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(30)),
              child: Image.asset(
                img,
                height: 120,
                width: 170,
                scale: 0.0001,
              ),
            ),
            const SizedBox(height: 13),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  prodName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.lightGreen,
                )
              ],
            )
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
