class Products {
  String category;
  Products(this.category);

// WINDOWS
  var windows = <Map<String, dynamic>>[
    {
      "prodId": 01,
      "name": "Metallic Window",
      "price": 380000,
      "image": "assets/images/w1.jpg",
      "description": "Very durable product made from the finest materials.",
    },
    {
      "prodId": 02,
      "name": "Metallic Window",
      "price": 170000,
      "image": "assets/images/w2.jpg",
      "description": "Very durable product made from the finest materials.",
    },
    {
      "prodId": 03,
      "name": "Metallic Window",
      "price": 210000,
      "image": "assets/images/w3.jpg",
      "description": "Very durable product made from the finest materials.",
    },
    {
      "prodId": 04,
      "name": "Metallic Window",
      "price": 25000,
      "image": "assets/images/w4.jpg",
      "description": "Very durable product made from the finest materials.",
    },
    {
      "prodId": 05,
      "name": "Metallic Window",
      "price": 450000,
      "image": "assets/images/w6.jpg",
      "description": "Very durable product made from the finest materials.",
    },
    {
      "prodId": 06,
      "name": "Metallic Window",
      "price": 320000,
      "image": "assets/images/w5.jpg",
      "description": "Very durable product made from the finest materials.",
    },
  ];

// DOORS
  var doors = <Map<String, dynamic>>[
    {
      "prodId": 01,
      "name": "Metallic Door",
      "price": 380000,
      "image": "assets/images/d.jpg",
      "description": "Very durable product made from the finest materials.",
    },
    {
      "prodId": 02,
      "name": "Metallic Door",
      "price": 170000,
      "image": "assets/images/d1.jpg",
      "description": "Very durable product made from the finest materials.",
    },
    {
      "prodId": 03,
      "name": "Metallic Door",
      "price": 210000,
      "image": "assets/images/d3.jpg",
      "description": "Very durable product made from the finest materials.",
    },
    {
      "prodId": 04,
      "name": "Metallic Door",
      "price": 25000,
      "image": "assets/images/d5.jpg",
      "description": "Very durable product made from the finest materials.",
    },
  ];

// BED
  var beds = <Map<String, dynamic>>[
    {
      "prodId": 01,
      "name": "Metallic Bed",
      "price": 890000,
      "image": "assets/images/bed2.jpg",
      "description": "Very durable product made from the finest materials.",
    },
  ];

// BALCONY
  var balcony = <Map<String, dynamic>>[
    {
      "prodId": 01,
      "name": "Metallic Bed",
      "price": 890000,
      "image": "assets/images/s1.jpg",
      "description": "Very durable product made from the finest materials.",
    },
    {
      "prodId": 01,
      "name": "Metallic Bed",
      "price": 890000,
      "image": "assets/images/stairs1.jpg",
      "description": "Very durable product made from the finest materials.",
    },
    {
      "prodId": 01,
      "name": "Metallic Bed",
      "price": 890000,
      "image": "assets/images/rail.png",
      "description": "Very durable product made from the finest materials.",
    },
  ];

// ROOFING
  var roofing = <Map<String, dynamic>>[
    {
      "prodId": 01,
      "name": "Black Iron Sheets",
      "price": 4000000,
      "image": "assets/images/roofing.jpg",
      "description": "Very durable product made from the finest materials.",
    },
    {
      "prodId": 01,
      "name": "Okuseleka",
      "price": 890000,
      "image": "assets/images/roofing1.jpg",
      "description": "Very durable product made from the finest materials.",
    },
    {
      "prodId": 01,
      "name": "Mategula",
      "price": 890000,
      "image": "assets/images/roofing2.jpg",
      "description": "Very durable product made from the finest materials.",
    },
    {
      "prodId": 01,
      "name": "Mategula black",
      "price": 890000,
      "image": "assets/images/roofing3.jpg",
      "description": "Very durable product made from the finest materials.",
    },
  ];

// WOOD DOORS
  var wooddoors = <Map<String, dynamic>>[
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

  returnProdList() {
    if (category == "Windows") {
      return windows;
    } else if (category == "Metal Doors") {
      return doors;
    } else if (category == "Bed") {
      return beds;
    } else if (category == "Balcony") {
      return balcony;
    } else if (category == "Roofing") {
      return roofing;
    } else if (category == "Wood Doors") {
      return wooddoors;
    }
  }
}
