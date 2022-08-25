class ForumDataModel{
  String? type;
  String? message;
  List<ForumData>? data = [];

  ForumDataModel.fromJson(Map<String, dynamic> map)
  {
    type = map['type'];
    message = map['message'];
    map['data'].forEach((element){
      data!.add(ForumData.fromJson(element));
    });
  }
}

class ForumData{

  String? forumId;
  String? title;
  String? description;
  String? imageUrl;
  String? userId;
  List<ForumLikes>? forumLikes = [];
  List<ForumComments>? forumComments = [];
  UserData? user;

  ForumData.fromJson(Map<String, dynamic> map)
  {
    forumId = map['forumId'];
    title = map['title'];
    description = map['description'];
    imageUrl = map['imageUrl'];
    userId = map['userId'];
    map['ForumLikes'].forEach((element){
      forumLikes!.add(ForumLikes.fromJson(element));
    });

    map['ForumComments'].forEach((element){
      forumComments!.add(ForumComments.fromJson(element));
    });

    user = UserData.fromJson(map['user']);
  }
}

class ForumLikes{
  String? forumId;
  String? userId;

  ForumLikes.fromJson(Map<String, dynamic> map)
  {
    forumId = map['forumId'];
    userId = map['userId'];
  }

}

class ForumComments{
  String? forumCommentId;
  String? forumId;
  String? userId;
  String? comment;
  String? createdAt;

  ForumComments.fromJson(Map<String, dynamic> map)
  {
    forumCommentId = map['forumCommentId'];
    forumId = map['forumId'];
    userId = map['userId'];
    comment = map['comment'];
    createdAt = map['createdAt'];
  }

}

class UserData{
  String? firstName;
  String? lastName;
  String? imageUrl;

  UserData.fromJson(Map<String, dynamic> map)
  {
    firstName = map['firstName'];
    lastName = map['lastName'];
    imageUrl = map['imageUrl'];
  }

}


