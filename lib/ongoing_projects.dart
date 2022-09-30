import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mj_image_slider/mj_image_slider.dart';
import 'package:welding_app/constants.dart';

class OngoingProjects extends StatefulWidget {
  const OngoingProjects({Key? key}) : super(key: key);

  @override
  State<OngoingProjects> createState() => _OngoingProjectsState();
}

class _OngoingProjectsState extends State<OngoingProjects> {
  List<Map<String, List<dynamic>>> ongoing_projects = [];

  getProducts() {
    // getting the products from the database
    FirebaseFirestore.instance
        .collection("products")
        .doc("ongoing_projects")
        .get()
        .then((value) {
      setState(() {
        var response = value.data();
        List projects = response!["projects"];
        projects.forEach((element) {
          print("ELEMENT: ${element.runtimeType}");
          ongoing_projects.add(Map<String, List<dynamic>>.from(element));
          print("element added to ongoing projects");
        });
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
    print("BUILD METHOD: $ongoing_projects");
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

      // ONGOING PROJECTS
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
              "ONGOING PROJECTS",
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
            children: ongoing_projects.map((element) {
              List<dynamic>? images = element["images"];
              var _images = images!.toList();

              print("IMAGES: $_images");

              return Container(
                  margin: const EdgeInsets.all(22),
                  height: 250,
                  width: 300,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: MJImageSlider(
                        images: List<String>.from(_images),
                        useLocalAssetImages: false,
                        duration: const Duration(seconds: 3),
                        width: 200,
                        height: 200,
                        curve: Curves.easeInOutCubicEmphasized,
                      )));
            }).toList(),
          )
        ],
      ),
    );
  }
}
