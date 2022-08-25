class UserDataModel{
  String? type;
  String? message;
  UserData? data;

  UserDataModel.fromJson(Map<String, dynamic> map)
  {
    type = map['type'];
    message = map['message'];
    data = map['data'] != null? UserData.fromJson(map['data']): null;
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
  int? userPoints;
  List<NotificationData>? userNotification = [];

  UserData.fromJson(Map<String, dynamic> map)
  {
    userId = map['userId'];
    firstName = map['firstName'];
    lastName = map['lastName'];
    email = map['email'];
    imageUrl = map['imageUrl'];
    address = map['address'];
    role = map['role'];
    userPoints = map['UserPoints'];
    map['UserNotification'].forEach((element){
      userNotification!.add(NotificationData.fromJson(element));
    });
  }
}

class NotificationData{
  String? notificationId;
  String? userId;
  String? imageUrl;
  String? message;
  String? createdAt;

  NotificationData.fromJson(Map<String, dynamic> map)
  {
    notificationId = map['notificationId'];
    userId = map['userId'];
    imageUrl = map['imageUrl'];
    message = map['message'];
    createdAt = map['createdAt'];
  }
}