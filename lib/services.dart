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
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.chevron_left,
              size: 40,
            )),
        title: const Text(
          "PRODUCTS & SERVICES",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        foregroundColor: Color.fromARGB(255, 23, 22, 22),
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
                ),

                const SizedBox(width: 28),
                // METALLIC DOORS
                SingleService(
                  img: "assets/images/d2.webp",
                  service: "Main Doors",
                ),
              ],
            ),
            const SizedBox(height: 30),

            // ROW 2
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // GYPSUM CEILINGS
                SingleService(
                  img: "assets/images/gypsum1.png",
                  service: "Gypsum Ceilings",
                ),

                const SizedBox(width: 28),
                // UNDERGROUND WELL ESCAVATION
                SingleService(
                  img: "assets/images/well3.jpg",
                  service: "Underground Well Escavation",
                ),
              ],
            ),

            const SizedBox(height: 30),

            // ROW 3

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // HOUSE CONSTRUCTION
                SingleService(
                  img: "assets/images/c1.png",
                  service: "Construction",
                ),

                const SizedBox(width: 28),
                // BALCONY
                SingleService(
                  img: "assets/images/balcony.png",
                  service: "Balcony",
                ),
              ],
            ),

            const SizedBox(height: 30),

            // ROW 4

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // METALLIC GATE
                SingleService(
                  img: "assets/images/g1.jpg",
                  service: "Metallic Gates",
                ),

                const SizedBox(width: 28),
                // WOODEN DOORS
                SingleService(
                  img: "assets/images/wdoor.jpg",
                  service: "Wooden Doors",
                ),
              ],
            ),

            const SizedBox(height: 30),
            // ROW 5
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // BACK DOORS
                SingleService(
                  img: "assets/images/bdoor6.jpg",
                  service: "Back Door",
                ),

                const SizedBox(width: 28),
                // ROOFING AND CONSTRUCTION
                SingleService(
                  img: "assets/images/roofing.png",
                  service: "Roofing",
                ),
              ],
            ),

            const SizedBox(height: 30),

            // ROW 6
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // HOUSE CONSTRUCTION
                SingleService(
                  img: "assets/images/painting.jpg",
                  service: "Painting",
                ),

                const SizedBox(width: 28),
                // FLOORING
                SingleService(
                  img: "assets/images/f2.jpg",
                  service: "Flooring",
                ),
              ],
            ),
            const SizedBox(height: 50)
          ],
        ),
      ),
    );
  }
}
