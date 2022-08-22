import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gallery_zoom_slides/gallery_zoom_slides.dart';
import 'package:mj_image_slider/mj_image_slider.dart';
import 'package:welding_app/constants.dart';

class OngoingProjects extends StatefulWidget {
  const OngoingProjects({Key? key}) : super(key: key);

  @override
  State<OngoingProjects> createState() => _OngoingProjectsState();
}

class _OngoingProjectsState extends State<OngoingProjects> {
  @override
  Widget build(BuildContext context) {
    var ongoing = [
      "assets/images/ongoing3.jpeg",
    ];
    var ongoing1 = [
      "assets/images/ongoing.jpeg",
    ];
    var ongoing2 = [
      "assets/images/ongoing2.jpeg",
    ];
    var ongoing3 = [
      "assets/images/ongoing4.jpeg",
      "assets/images/ongoing5.jpeg",
      "assets/images/ongoing8.jpeg",
      "assets/images/ongoing9.jpeg",
    ];
    var ongoing4 = [
      "assets/images/ongoing6.jpeg",
      "assets/images/ongoing7.jpeg",
    ];

// // IMAGE SLIDERS
//     final List<Widget> imageSliders = imgList
//         .map((item) => Container(
//               margin: EdgeInsets.all(5.0),
//               height: 600,
//               child: ClipRRect(
//                   borderRadius: const BorderRadius.all(Radius.circular(15.0)),
//                   child: Stack(
//                     children: <Widget>[
//                       Image.asset(
//                         item,
//                         fit: BoxFit.cover,
//                         width: 1000.0,
//                         height: 400,
//                       ),
//                     ],
//                   )),
//             ))
//         .toList();

//     int _current = 0;
//     final CarouselController _controller = CarouselController();

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
          Container(
            margin: const EdgeInsets.all(22),
            height: 270,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: MJImageSlider(
                images: ongoing,
                useLocalAssetImages: true,
                duration: const Duration(seconds: 3),
                width: 200,
                height: 200,
                curve: Curves.easeInOutCubicEmphasized,
              ),
            ),
          ),

          // images slider
          Container(
            margin: const EdgeInsets.all(22),
            height: 270,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: MJImageSlider(
                images: ongoing1,
                useLocalAssetImages: true,
                duration: const Duration(seconds: 3),
                width: 200,
                height: 200,
                curve: Curves.easeInOutCubicEmphasized,
              ),
            ),
          ),

          // images slider
          Container(
            margin: const EdgeInsets.all(22),
            height: 270,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: MJImageSlider(
                images: ongoing2,
                useLocalAssetImages: true,
                duration: const Duration(seconds: 3),
                width: 200,
                height: 200,
                curve: Curves.easeInOutCubicEmphasized,
              ),
            ),
          ),

          // images slider
          Container(
            margin: const EdgeInsets.all(22),
            height: 270,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: MJImageSlider(
                images: ongoing3,
                useLocalAssetImages: true,
                duration: const Duration(seconds: 3),
                width: 200,
                height: 200,
                curve: Curves.easeInOutCubicEmphasized,
              ),
            ),
          ),

          // images slider
          Container(
            margin: const EdgeInsets.all(22),
            height: 270,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: MJImageSlider(
                images: ongoing4,
                useLocalAssetImages: true,
                duration: const Duration(seconds: 3),
                width: 200,
                height: 200,
                curve: Curves.easeInOutCubicEmphasized,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
