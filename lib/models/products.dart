import 'windows.dart';
import 'gypsum.dart';
import 'wells.dart';
import 'maindoors.dart';
import 'balcony.dart';
import 'roofing.dart';
import 'woodendoors.dart';
import 'gates.dart';
import 'houseConstruction.dart';
import 'flooring.dart';



class Products {
  String category;
  Products(this.category);

  returnProdList() {
    if (category == "Windows") {
      return windows;
    } else if (category == "Main Doors") {
      return maindoors;
    } else if (category == "Gypsum Ceilings") {
      return gypsum;
    } else if (category == "Undeground Well Escavation") {
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
    }
    } else if (category == "Roofing") {
      return roofing;
    }
    } else if (category == "Painting") {
      return painting;
    }
     else if (category == "Flooring") {
      return flooring;
    }
  }
}
