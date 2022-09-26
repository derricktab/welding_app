import 'package:cloud_firestore/cloud_firestore.dart';

var windows = <Map<String, dynamic>>[];
var backdoors = <Map<String, dynamic>>[];
var balcony = <Map<String, dynamic>>[];
var gates = <Map<String, dynamic>>[];
var gypsum = <Map<String, dynamic>>[];
var construction = <Map<String, dynamic>>[];
var painting = <Map<String, dynamic>>[];
var roofing = <Map<String, dynamic>>[];
var wells = <Map<String, dynamic>>[];
var woodendoors = <Map<String, dynamic>>[];
var flooring = <Map<String, dynamic>>[];
var maindoors = <Map<String, dynamic>>[];

class Products {
  getWells() async {
    var wellsSnapshot = await FirebaseFirestore.instance
        .collection("products")
        .doc("wells")
        .collection("wells")
        .snapshots();
    // var _wells = <Map<String, dynamic>>[];
    // wells
    wellsSnapshot.first.then((snapshot) {
      for (var doc in snapshot.docs) {
        wells.add(doc.data());
      }
    });

    print(wells);
  }

  String category;
  Products(this.category);

  returnProdList() {
    if (category == "Windows") {
// Windows Snapshot
      var windowsSnapshot = FirebaseFirestore.instance
          .collection("products")
          .doc("windows")
          .collection("windows")
          .snapshots();

      // Windows
      windowsSnapshot.listen((snapshot) {
        snapshot.docs.forEach((doc) {
          windows.add(doc.data());
        });
      });

      return windows;
    } else if (category == "Main Doors") {
// Main Doors Snapshot
      var maindoorsSnapshot = FirebaseFirestore.instance
          .collection("products")
          .doc("maindoor")
          .collection("maindoor")
          .snapshots();
      // MainDoors
      maindoorsSnapshot.listen((snapshot) {
        snapshot.docs.forEach((doc) {
          maindoors.add(doc.data());
        });
      });
      print(maindoors.length);
      return maindoors;
    } else if (category == "Gypsum Ceilings") {
// Gypsum Snapshot
      var gypsumSnapshot = FirebaseFirestore.instance
          .collection("products")
          .doc("gypsum")
          .collection("gypsum")
          .snapshots();
      // Gypsum
      gypsumSnapshot.listen((snapshot) {
        snapshot.docs.forEach((doc) {
          gypsum.add(doc.data());
        });
      });
      return gypsum;
    } else if (category == "Underground Well Escavation") {
// Wells Snapshot
      getWells();
      print("WELLS: ${wells}");
      return wells;
    } else if (category == "Construction") {
// construction Snapshot
      var constructionSnapshot = FirebaseFirestore.instance
          .collection("products")
          .doc("construction")
          .collection("construction")
          .snapshots();
      constructionSnapshot.listen((snapshot) {
        snapshot.docs.forEach((doc) {
          construction.add(doc.data());
        });
      });
      return construction;
    } else if (category == "Balcony") {
// Balcony Snapshot
      var balconySnapshot = FirebaseFirestore.instance
          .collection("products")
          .doc("balcony")
          .collection("balcony")
          .snapshots();
      // balcony
      balconySnapshot.listen((snapshot) {
        snapshot.docs.forEach((doc) {
          balcony.add(doc.data());
        });
      });
      return balcony;
    } else if (category == "Metallic Gates") {
// Gates Snapshot
      var gatesSnapshot = FirebaseFirestore.instance
          .collection("products")
          .doc("gates")
          .collection("gates")
          .snapshots()
          .first
          .then((value) {
        value.docs.forEach((doc) {
          gates.add(doc.data());
        });
      });
      print(gates.length);

      return gates;
    } else if (category == "Wooden Doors") {
// Wooden Doors Snapshot
      var woodendoorsSnapshot = FirebaseFirestore.instance
          .collection("products")
          .doc("woodendoors")
          .collection("woodendoors")
          .snapshots();
      // woodendoors
      woodendoorsSnapshot.listen((snapshot) {
        snapshot.docs.forEach((doc) {
          woodendoors.add(doc.data());
        });
      });
      return woodendoors;
    } else if (category == "Back Doors") {
// Back Doors Snapshot
      var backdoorsSnapshot = FirebaseFirestore.instance
          .collection("products")
          .doc("backdoors")
          .collection("backdoors")
          .snapshots();
      // backdoors
      backdoorsSnapshot.listen((snapshot) {
        snapshot.docs.forEach((doc) {
          backdoors.add(doc.data());
        });
      });
      return backdoors;
    } else if (category == "Roofing") {
      // Roofing Snapshot
      var roofingSnapshot = FirebaseFirestore.instance
          .collection("products")
          .doc("roofing")
          .collection("roofing")
          .snapshots();
      // roofing
      roofingSnapshot.listen((snapshot) {
        snapshot.docs.forEach((doc) {
          roofing.add(doc.data());
        });
      });
      return roofing;
    } else if (category == "Painting") {
// Painting Snapshot
      var paintingSnapshot = FirebaseFirestore.instance
          .collection("products")
          .doc("painting")
          .collection("painting")
          .snapshots();

      // painting
      paintingSnapshot.listen((snapshot) {
        snapshot.docs.forEach((doc) {
          painting.add(doc.data());
        });
      });
      return painting;
    } else if (category == "Flooring") {
// Flooring Snapshot
      var flooringSnapshot = FirebaseFirestore.instance
          .collection("products")
          .doc("flooring")
          .collection("flooring")
          .snapshots();
      // Flooring
      flooringSnapshot.listen((snapshot) {
        snapshot.docs.forEach((doc) {
          flooring.add(doc.data());
        });
      });
      return flooring;
    }
  }
}
