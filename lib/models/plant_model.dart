class PlantModel{

  String? plantId;
  String? name;
  String? description;
  String? imageUrl;
  int? waterCapacity;
  int? sunLight;
  int? temperature;

  PlantModel.fromJson(Map<String, dynamic> map)
  {
    plantId = map['plantId'];
    name = map['name'];
    description = map['description'];
    imageUrl = map['imageUrl'];
    waterCapacity = map['waterCapacity'];
    sunLight = map['sunLight'];
    temperature = map['temperature'];
  }
}