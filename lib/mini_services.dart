import 'package:flutter/material.dart';
import 'package:welding_app/prod_list.dart';
import 'package:welding_app/product.dart';

class MiniServices extends StatelessWidget {
  String img;
  String service;

  MiniServices({
    Key? key,
    required this.img,
    required this.service,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(color: Colors.grey, spreadRadius: 1.5),
            BoxShadow(color: Colors.green, spreadRadius: 0.5),
            BoxShadow(color: Colors.blue, spreadRadius: 0.4),
          ],
        ),
        height: 140,
        width: 120,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(30)),
              child: Image.asset(
                img,
                height: 100,
                width: 100,
              ),
            ),
            // const SizedBox(height: ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      service,
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey),
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.lightGreen,
                  )
                ],
              ),
            )
          ],
        ),
      ),
      onTap: () {
        print(service);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: ((context) => ProdList(
                      category: service,
                    ))));
      },
    );
  }
}
