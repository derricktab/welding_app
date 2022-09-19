// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firestore_search/firestore_search.dart';
// import 'package:flutter/material.dart';

// class DataModel {
//   final String? description;
//   final List? image;
//   final String? name;
//   final String? price;

//   DataModel({this.name, this.description, this.image, this.price});

//   //Create a method to convert QuerySnapshot from Cloud Firestore to a list of objects of this DataModel
//   //This function in essential to the working of FirestoreSearchScaffold

//   List<DataModel> dataListFromSnapshot(QuerySnapshot querySnapshot) {
//     return querySnapshot.docs.map((snapshot) {
//       final Map<String, dynamic> dataMap =
//           snapshot.data() as Map<String, dynamic>;

//       return DataModel(
//           name: dataMap['name'],
//           description: dataMap['description'],
//           image: dataMap['image'],
//           price: dataMap['price']);
//     }).toList();
//   }
// }

// class Search extends StatefulWidget {
//   const Search({super.key});

//   @override
//   State<Search> createState() => _SearchState();
// }

// class _SearchState extends State<Search> {
//   @override
//   Widget build(BuildContext context) {
//     return FirestoreSearchScaffold(
//       firestoreCollectionName: 'products',
//       searchBy: 'name',
//       scaffoldBody: Center(),
//       dataListFromSnapshot: DataModel().dataListFromSnapshot,
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           final List<DataModel>? dataList = snapshot.data;
//           if (dataList!.isEmpty) {
//             return const Center(
//               child: Text('No Results Returned'),
//             );
//           }
//           return ListView.builder(
//               itemCount: dataList.length,
//               itemBuilder: (context, index) {
//                 final DataModel data = dataList[index];

//                 return Column(
//                   mainAxisSize: MainAxisSize.min,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Text(
//                         '${data.name}',
//                         style: Theme.of(context).textTheme.headline6,
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(
//                           bottom: 8.0, left: 8.0, right: 8.0),
//                       child: Text('${data.description}',
//                           style: Theme.of(context).textTheme.bodyText1),
//                     )
//                   ],
//                 );
//               });
//         }

//         if (snapshot.connectionState == ConnectionState.done) {
//           if (!snapshot.hasData) {
//             return const Center(
//               child: Text('No Results Returned'),
//             );
//           }
//         }
//         return const Center(
//           child: CircularProgressIndicator(),
//         );
//       },
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:welding_app/single_product.dart';

class Search extends StatefulWidget {
  final query;

  const Search({Key? key, required this.query}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  var _products = <Map<String, dynamic>>[];

  // Method to fetch products
  getItems(query) async {
    var result = await FirebaseFirestore.instance
        .collection("products")
        .snapshots()
        .forEach(((items) {
      items.docs.forEach((doc) {
        print("FETCHED DATA ${doc.data()}");
      });
    }));

    print(result.size);
    result.docs.forEach((doc) {
      _products.add(doc.data());
      print("${doc.id} ADDED!");
    });
    var output = _products.where((product) =>
        product["name"].toLowerCase().contains(query.toLowerCase()).toList());

    print(output);

    // print(_products.length);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getItems(widget.query);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _products.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 239, 251, 247),
        // backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.chevron_left,
                size: 40,
              )),
          title: Text(widget.query),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: Colors.black,
        ),
        body: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          childAspectRatio: 0.8,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          children: _products.map((product) {
            return SingleProduct(
              img: product["image"].toString(),
              prodName: product["name"].toString(),
              price: product["price"].toString(),
              prodId: product["prodId"].toString(),
              description: product["description"].toString(),
            );
          }).toList(),
        ));
  }
}
