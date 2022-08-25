// class HomeDataModel{
//   String? type;
//   String? message;
//   List<ProductData>? data = [];
//
//   HomeDataModel.fromJson(Map<String, dynamic> map)
//   {
//     type = map['type'];
//     message = map['message'];
//     map['data'].forEach((element){
//       data!.add(ProductData.fromJson(element));
//     });
//   }
// }
//
// class ProductData{
//
//   late String plantId;
//   String? name;
//   String? description;
//   String? imageUrl;
//   int? waterCapacity;
//   int? sunLight;
//   int? temperature;
//
//   ProductData.fromJson(Map<String, dynamic> map)
//   {
//     plantId = map['plantId'];
//     name = map['name'];
//     description = map['description'];
//     imageUrl = map['imageUrl'];
//     waterCapacity = map['waterCapacity'];
//     sunLight = map['sunLight'];
//     temperature = map['temperature'];
//   }
// }
//
//
