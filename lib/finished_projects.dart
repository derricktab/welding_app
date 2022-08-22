import 'package:carousel_slider/carousel_slider.dart';
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
  @override
  Widget build(BuildContext context) {
    var finished = [
      "assets/images/finished.jpeg",
    ];
    var finished1 = [
      "assets/images/finished1.jpeg",
    ];
    var finished2 = [
      "assets/images/finished2.jpeg",
      "assets/images/finished3.jpeg",
    ];
    var finished3 = [
      "assets/images/finished.jpeg",
      "assets/images/finished1.jpeg",
      "assets/images/finished2.jpeg"
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
          Container(
            margin: const EdgeInsets.all(22),
            height: 270,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: MJImageSlider(
                images: finished,
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
                images: finished1,
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
                images: finished3,
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
