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

// Windows Snapshot
var windowsSnapshot = FirebaseFirestore.instance
    .collection("products")
    .doc("windows")
    .collection("windows")
    .snapshots();

// Main Doors Snapshot
var maindoorsSnapshot = FirebaseFirestore.instance
    .collection("products")
    .doc("maindoor")
    .collection("maindoor")
    .snapshots();

// Wooden Doors Snapshot
var woodendoorsSnapshot = FirebaseFirestore.instance
    .collection("products")
    .doc("woodendoors")
    .collection("woodendoors")
    .snapshots();

// Back Doors Snapshot
var backdoorsSnapshot = FirebaseFirestore.instance
    .collection("products")
    .doc("backdoors")
    .collection("backdoors")
    .snapshots();

// Balcony Snapshot
var balconySnapshot = FirebaseFirestore.instance
    .collection("products")
    .doc("balcony")
    .collection("balcony")
    .snapshots();

// Gates Snapshot
var gatesSnapshot = FirebaseFirestore.instance
    .collection("products")
    .doc("gates")
    .collection("gates")
    .snapshots();

// Gypsum Snapshot
var gypsumSnapshot = FirebaseFirestore.instance
    .collection("products")
    .doc("gypsum")
    .collection("gypsum")
    .snapshots();

// construction Snapshot
var constructionSnapshot = FirebaseFirestore.instance
    .collection("products")
    .doc("construction")
    .collection("construction")
    .snapshots();

// Painting Snapshot
var paintingSnapshot = FirebaseFirestore.instance
    .collection("products")
    .doc("painting")
    .collection("painting")
    .snapshots();

// Roofing Snapshot
var roofingSnapshot = FirebaseFirestore.instance
    .collection("products")
    .doc("roofing")
    .collection("roofing")
    .snapshots();

// Wells Snapshot
var wellsSnapshot = FirebaseFirestore.instance
    .collection("products")
    .doc("wells")
    .collection("wells")
    .snapshots();

// Flooring Snapshot
var flooringSnapshot = FirebaseFirestore.instance
    .collection("products")
    .doc("flooring")
    .collection("flooring")
    .snapshots();

class Products {
  String category;
  Products(this.category);

  returnProdList() {
    // Windows
    windowsSnapshot.listen((snapshot) {
      snapshot.docs.forEach((doc) {
        windows.add(doc.data());
      });
    });

    // backdoors
    backdoorsSnapshot.listen((snapshot) {
      snapshot.docs.forEach((doc) {
        backdoors.add(doc.data());
      });
    });

    // balcony
    balconySnapshot.listen((snapshot) {
      snapshot.docs.forEach((doc) {
        balcony.add(doc.data());
      });
    });

    // Flooring
    flooringSnapshot.listen((snapshot) {
      snapshot.docs.forEach((doc) {
        flooring.add(doc.data());
      });
    });

    // Gates
    gatesSnapshot.listen((snapshot) {
      snapshot.docs.forEach((doc) {
        gates.add(doc.data());
      });
    });

    // Gypsum
    gypsumSnapshot.listen((snapshot) {
      snapshot.docs.forEach((doc) {
        gypsum.add(doc.data());
      });
    });

    // MainDoors
    maindoorsSnapshot.listen((snapshot) {
      snapshot.docs.forEach((doc) {
        maindoors.add(doc.data());
      });
    });

    // roofing
    roofingSnapshot.listen((snapshot) {
      snapshot.docs.forEach((doc) {
        roofing.add(doc.data());
      });
    });

    // wells
    wellsSnapshot.listen((snapshot) {
      snapshot.docs.forEach((doc) {
        wells.add(doc.data());
      });
    });

    // woodendoors
    woodendoorsSnapshot.listen((snapshot) {
      snapshot.docs.forEach((doc) {
        woodendoors.add(doc.data());
      });
    });

    // gates
    gatesSnapshot.listen((snapshot) {
      snapshot.docs.forEach((doc) {
        gates.add(doc.data());
      });
    });

    // painting
    paintingSnapshot.listen((snapshot) {
      snapshot.docs.forEach((doc) {
        painting.add(doc.data());
      });
    });

    if (category == "Windows") {
      return windows;
    } else if (category == "Main Doors") {
      print(maindoors.length);
      return maindoors;
    } else if (category == "Gypsum Ceilings") {
      return gypsum;
    } else if (category == "Underground Well Escavation") {
      return wells;
    } else if (category == "Construction") {
      return construction;
    } else if (category == "Balcony") {
      return balcony;
    } else if (category == "Metallic Gates") {
      return gates;
    } else if (category == "Wooden Doors") {
      return woodendoors;
    } else if (category == "Back Doors") {
      return backdoors;
    } else if (category == "Roofing") {
      return roofing;
    } else if (category == "Painting") {
      return painting;
    } else if (category == "Flooring") {
      return flooring;
    }
  }
}
