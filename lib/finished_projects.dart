import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gallery_zoom_slides/gallery_zoom_slides.dart';
import 'package:welding_app/constants.dart';

class FinishedProjects extends StatefulWidget {
  const FinishedProjects({Key? key}) : super(key: key);

  @override
  State<FinishedProjects> createState() => _FinishedProjectsState();
}

class _FinishedProjectsState extends State<FinishedProjects> {
  @override
  Widget build(BuildContext context) {

    var imgList = ["assets/images/finished1.jpeg"];

    var finished_projects = <Map<String, dynamic>>[
      {
        "prodId": 01,
        "name": "Wooden Door",
        "price": 278000,
        "image": "assets/images/wdoor.jpg",
        "description": "Very durable product made from the finest materials.",
      },
      {
        "prodId": 02,
        "name": "Wooden Door",
        "price": 190000,
        "image": "assets/images/wdoor1.jpg",
        "description": "Very durable product made from the finest materials.",
      },
      {
        "prodId": 02,
        "name": "Closet",
        "price": 600000,
        "image": "assets/images/f1.jpg",
        "description": "Very durable product made from the finest materials.",
      },
    ];

// IMAGE SLIDERS
    final List<Widget> imageSliders = imgList
        .map((item) => Container(
              margin: EdgeInsets.all(5.0),
              height: 600,
              child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                  child: Stack(
                    children: <Widget>[
                      Image.asset(
                        item,
                        fit: BoxFit.cover,
                        width: 1000.0,
                        height: 400,
                      ),
                    ],
                  )),
            ))
        .toList();

    int _current = 0;
    final CarouselController _controller = CarouselController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Finished Projects'),
        centerTitle: true,
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
          GestureDetector(
            onTap: (){
              Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => GalleryZoomSlides(
                            imgList,0)));
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              height: 250,
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(20),
              ),
              child: ClipRRect(
                child: Image.asset("assets/images/finished.jpeg"),
              ),
            ),
          ),
    
        ],
      ),
    );
  }
}
