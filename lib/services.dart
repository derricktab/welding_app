import 'package:flutter/material.dart';
import 'package:welding_app/single_service.dart';

class Services extends StatefulWidget {
  const Services({Key? key}) : super(key: key);

  @override
  State<Services> createState() => _ServicesState();
}

class _ServicesState extends State<Services> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 239, 251, 247),
      appBar: AppBar(
        title: const Text("SERVICES WE OFFER"),
        centerTitle: true,
        foregroundColor: Color.fromARGB(255, 0, 154, 5),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            const SizedBox(height: 25),

            // ROW 1
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // WINDOWS
                SingleService(
                    img: "assets/images/w4.jpg",
                    service: "Windows",
                    address: "windows"),

                const SizedBox(width: 28),
                // METALLIC DOORS
                SingleService(
                    img: "assets/images/d2.webp",
                    service: "Doors",
                    address: "metal door"),
              ],
            ),
            const SizedBox(height: 30),
            // ROW 2
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // METALLIC GATE
                SingleService(
                    img: "assets/images/g1.jpg",
                    service: "Metallic Gates",
                    address: "metal gate"),

                const SizedBox(width: 28),
                // RAILINGS
                SingleService(
                    img: "assets/images/s1.jpg",
                    service: "Stair Railings",
                    address: "railings"),
              ],
            ),
            const SizedBox(height: 30),
            // ROW 3
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // BALCONY
                SingleService(
                    img: "assets/images/b3.png",
                    service: "Balcony",
                    address: "balcony"),

                const SizedBox(width: 28),
                // ROOFING AND CONSTRUCTION
                SingleService(
                    img: "assets/images/roofing.png",
                    service: "Roofing",
                    address: "Roofing"),
              ],
            ),

            const SizedBox(height: 30),

            // ROW 4
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // HOUSE CONSTRUCTION
                SingleService(
                    img: "assets/images/c1.png",
                    service: "Construction",
                    address: "House"),

                const SizedBox(width: 28),
                // FLOORING
                SingleService(
                    img: "assets/images/f2.jpg",
                    service: "Flooring",
                    address: "Flooring"),
              ],
            ),
            const SizedBox(height: 50)
          ],
        ),
      ),
    );
  }
}
