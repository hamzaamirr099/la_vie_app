class AuthorizationDataModel{
  String? type;
  String? message;
  AllData? data;

  AuthorizationDataModel.fromJson(Map<String, dynamic> map)
  {
    type = map['type'];
    message = map['message'];
    data = map['data'] != null? AllData.fromJson(map['data']): null;
  }
}

class AllData{
  UserData? user;
  String? accessToken;
  String? refreshToken;

  AllData.fromJson(Map<String, dynamic> map)
  {
    user = map['user'] != null ? UserData.fromJson(map['user']) : null;
    accessToken = map['accessToken'];
    refreshToken = map['refreshToken'];
  }
}

class UserData{
  String? userId;
  String? firstName;
  String? lastName;
  String? email;
  String? imageUrl;
  String? address;
  String? role;

  UserData.fromJson(Map<String, dynamic> map)
  {
    userId = map['userId'];
    firstName = map['firstName'];
    lastName = map['lastName'];
    email = map['email'];
    imageUrl = map['imageUrl'];
    address = map['address'];
    role = map['role'];
  }
}