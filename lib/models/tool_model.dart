class ToolModel{

  String? toolId;
  String? name;
  String? description;
  String? imageUrl;


  ToolModel.fromJson(Map<String, dynamic> map)
  {
    toolId = map['toolId'];
    name = map['name'];
    description = map['description'];
    imageUrl = map['imageUrl'];
  }
}