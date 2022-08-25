class SeedModel{

  String? seedId;
  String? name;
  String? description;
  String? imageUrl;


  SeedModel.fromJson(Map<String, dynamic> map)
  {
    seedId = map['seedId'];
    name = map['name'];
    description = map['description'];
    imageUrl = map['imageUrl'];
  }
}