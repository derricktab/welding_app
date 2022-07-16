import 'package:flutter/material.dart';

class SingleService extends StatelessWidget {
  String img;
  String service;
  String address;

  SingleService({
    Key? key,
    required this.img,
    required this.service,
    required this.address,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(color: Colors.grey, spreadRadius: 1.5),
            BoxShadow(color: Colors.green, spreadRadius: 0.5),
          ],
        ),
        height: 170,
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
                  service,
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
        print(address);
      },
    );
  }
}
