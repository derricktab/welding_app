import 'package:flutter/material.dart';
import 'package:welding_app/prod_list.dart';
import 'package:welding_app/service.dart';

class SingleService extends StatelessWidget {
  String img;
  String service;

  SingleService({
    Key? key,
    required this.img,
    required this.service,
  }) : super(key: key);

  final _products = <String>[
    "Windows",
    "Main Doors",
    "Gypsum Ceilings",
    "Balcony",
    "Metallic Gates",
    "Wooden Doors",
    "Back Doors",
  ];

  final _services = <String>[
    "Flooring",
    "Painting",
    "Roofing",
    "Construction",
    "Underground Well Escavation",
  ];

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
        height: 170,
        width: 150,
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(30)),
                child: Image.asset(
                  img,
                  height: 120,
                  width: 170,
                  scale: 0.0001,
                ),
              ),
            ),
            const SizedBox(height: 13),
            Padding(
              padding: const EdgeInsets.only(bottom: 15, left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      service,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      onTap: () {
        if (_products.contains(service)) {
          print("THIS IS A PRODUCT");
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProdList(category: service)));
        } else if (_services.contains(service)) {
          print("THIS IS A SERVICE");
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => OurService(category: service)));
        }
      },
    );
  }
}
