import 'package:la_vie/models/plant_model.dart';
import 'package:la_vie/models/seed_model.dart';
import 'package:la_vie/models/tool_model.dart';

class ProductsModel{
  String? type;
  String? message;
  List<ProductData>? data = [];

  ProductsModel.fromJson(Map<String, dynamic> map)
  {
    type = map['type'];
    message = map['message'];
    map['data'] != null ? map['data'].forEach((element){
      data!.add(ProductData.fromJson(element));
    }) : [];
  }
}

class ProductData{
  String? productId;
  String? name;
  String? description;
  String? imageUrl;
  String? type;
  int? price;
  bool? available;
  SeedModel? seed;
  PlantModel? plant;
  ToolModel? tool;

  int amount = 1; // to specify the amount of this product in cart

  ProductData.fromJson(Map<String, dynamic> map)
  {
    productId = map['productId'];
    name = map['name'];
    description = map['description'];
    imageUrl = map['imageUrl'];
    type = map['type'];
    price = map['price'];
    available = map['available'];
    seed = map['seed'] != null? SeedModel.fromJson(map['seed']): null;
    plant = map['plant'] != null? PlantModel.fromJson(map['plant']): null;
    tool = map['tool'] != null? ToolModel.fromJson(map['tool']): null;

    // seed = SeedModel.fromJson(map['seed']);
    // plant = PlantModel.fromJson(map['plant']);
    // tool = ToolModel.fromJson(map['tool']);

  }
}