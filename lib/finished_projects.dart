import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gallery_zoom_slides/gallery_zoom_slides.dart';
import 'package:mj_image_slider/mj_image_slider.dart';
import 'package:welding_app/constants.dart';

class FinishedProjects extends StatefulWidget {
  const FinishedProjects({Key? key}) : super(key: key);

  @override
  State<FinishedProjects> createState() => _FinishedProjectsState();
}

class _FinishedProjectsState extends State<FinishedProjects> {
  List finished_projects = [];

  getProducts() {
    // getting the products from the database
    FirebaseFirestore.instance
        .collection("products")
        .doc("finished_projects")
        .get()
        .then((value) {
      setState(() {
        var response = value.data();
        List projects = response!["project"];
        projects.forEach((element) {
          print(element);
        });

        finished_projects.add(value.data());
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getProducts();
  }

  @override
  Widget build(BuildContext context) {
    print("BUILD METHOD: $finished_projects");
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryColor,
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left_rounded,
            size: 36,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),

      // FINISHED PROJECTS
      body: ListView(
        children: [
          // finished projects text
          Container(
            height: 150,
            padding: const EdgeInsets.only(top: 25),
            decoration: const BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(35),
                    bottomRight: Radius.circular(35))),
            child: const Text(
              "FINISHED PROJECTS",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 30),

          // images slider
          Column(
            children: finished_projects.map((element) {
              return Container(
                margin: const EdgeInsets.all(22),
                height: 270,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: MJImageSlider(
                    images: element["images"],
                    useLocalAssetImages: true,
                    duration: const Duration(seconds: 3),
                    width: 200,
                    height: 200,
                    curve: Curves.easeInOutCubicEmphasized,
                  ),
                ),
              );
            }).toList(),
          )
        ],
      ),
    );
  }
}
