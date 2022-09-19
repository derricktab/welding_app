import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:welding_app/prod_list.dart';
import 'package:welding_app/product.dart';

class MiniItem extends StatelessWidget {
  String image;
  String prodId;
  String prodName;
  String price;
  String description;

  MiniItem({
    Key? key,
    required this.image,
    this.prodId = '2',
    required this.prodName,
    required this.price,
    required this.description,
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
        height: 145,
        width: 120,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(30)),
              child: CachedNetworkImage(
                imageUrl: image,
                placeholder: (context, url) {
                  return Image.asset("assets/images/placeholder.gif");
                },
                height: 100,
                width: 100,
              ),
            ),
            // const SizedBox(height: ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Text(
                      prodName,
                      softWrap: true,
                      overflow: TextOverflow.clip,
                      maxLines: 3,
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
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: ((context) => Product(
                      image: image,
                      prodName: prodName,
                      price: price,
                      description: description,
                    ))));
      },
    );
  }
}
