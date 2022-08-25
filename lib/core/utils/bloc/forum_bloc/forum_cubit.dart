import 'dart:convert';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:la_vie/core/utils/network/local/cach_helper.dart';
import '../../../../core/shared/components.dart';
import '../../../../core/utils/network/remote/dio_helper.dart';
import '../../../../models/forum_data_model.dart';
import 'forum_states.dart';

class ForumCubit extends Cubit<ForumStates> {
  ForumCubit() : super(InitState());

  static ForumCubit get(context) => BlocProvider.of(context);

  ForumDataModel? allForums;

  List<ForumData> userForums = [];

  bool allForumsButton = true;

  bool isCommentPressed = false;

  String base64string = "";

  void switchAllForumsAndMyForums() {
    allForumsButton = !allForumsButton;
    emit(SwitchAllAndMyForumsState());
  }

  void getUserForums() {
    userForums = [];
    if (allForums != null) {
      for (ForumData element in allForums!.data!) {
        if (element.userId == CacheHelper.getData(key: 'userId')) {
          if (!userForums.contains(element)) {
            userForums.add(element);
          }
        }
      }
    }
  }

  Future<void> getAllForums({required String token}) async {
    try {
      Response value = await DioHelper.getData(
          url: '/api/v1/forums', token: token, query: {"search": ''});
      print(value.data);
      showToastMessage(message: "${value.data['message']}");
      allForums = ForumDataModel.fromJson(value.data);
      getUserForums();
      emit(SuccessAllForumsState());
    } on DioError catch (e) {
      if(e.response == null)
      {
        showToastMessage(message: "Check you connection", toastColor: Colors.red);
      }
      else
      {
        debugPrint(e.response!.data);
        showToastMessage(message: "${e.response!.data['message']}", toastColor: Colors.red);
      }
      emit(ErrorAllForumsState());
    }
  }

  void createPost(
      {required String token, required Map<String, dynamic> data}) async {
    try {
      Response value = await DioHelper.postData(
        url: '/api/v1/forums',
        token: token,
        data: data,
      );
      print(value.data);
      showToastMessage(message: "${value.data['message']}");
      getAllForums(token: token); //to update the forums
      emit(SuccessCreatePostState());
    } on DioError catch (e) {
      if(e.response == null)
      {
        showToastMessage(message: "Check you connection", toastColor: Colors.red);
      }
      else
      {
        debugPrint(e.response!.data);
        showToastMessage(message: "${e.response!.data['message']}", toastColor: Colors.red);
      }
      emit(ErrorCreatePostState());
    }
  }

  void likePost(
      {required String token,
      required Map<String, dynamic> data,
      required String? forumId}) async {
    try {
      Response value = await DioHelper.postData(
        url: '/api/v1/forums/$forumId/like',
        token: token,
        data: data,
      );
      print(value.data);
      showToastMessage(message: "${value.data['message']}");
      getAllForums(token: token); //to update the forums
      emit(SuccessLikePostState());
    } on DioError catch (e) {
      if(e.response == null)
      {
        showToastMessage(message: "Check you connection", toastColor: Colors.red);
      }
      else
      {
        debugPrint(e.response!.data);
        showToastMessage(message: "${e.response!.data['message']}", toastColor: Colors.red);
      }
      emit(ErrorLikePostState());
    }
  }

  void commentOnPost(
      {required String token,
      required Map<String, dynamic> data,
      required String? forumId}) async {
    isCommentPressed = false;
    try {
      Response value = await DioHelper.postData(
        url: '/api/v1/forums/$forumId/comment',
        token: token,
        data: data,
      );
      print(value.data);
      showToastMessage(message: "${value.data['message']}");
      getAllForums(token: token); //to update the forums
      emit(SuccessCommentOnPostState());
    } on DioError catch (e) {
      if(e.response == null)
      {
        showToastMessage(message: "Check you connection", toastColor: Colors.red);
      }
      else
      {
        debugPrint(e.response!.data);
        showToastMessage(message: "${e.response!.data['message']}", toastColor: Colors.red);
      }
      emit(ErrorCommentOnPostState());
    }
  }

  List<ForumData> searchResult = [];

  void searchForForums({required String token, required String searchString}) async {
    emit(LoadingState());
    try {
      searchResult = [];
      Response value = await DioHelper.getData(
          url: '/api/v1/forums', token: token, query: {"search": searchString});
      print(value.data);
      showToastMessage(message: "${value.data['message']}");
      // searchResult = value.data['data'];
      value.data['data'].forEach((element) {
        searchResult.add(ForumData.fromJson(element));
      });
      emit(SuccessSearchForForumsState());
    } on DioError catch (e) {
      if(e.response == null)
      {
        showToastMessage(message: "Check you connection", toastColor: Colors.red);
      }
      else
      {
        debugPrint(e.response!.data);
        showToastMessage(message: "${e.response!.data['message']}", toastColor: Colors.red);
      }
      emit(ErrorSearchForForumsState());
    }
  }

  Future<void> uploadImage() async {
    var pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      String imagePath = pickedFile.path;
      String imageExtension = imagePath.split('.').last;
      print(imageExtension);
      Uint8List imageBytes = await pickedFile.readAsBytes(); //convert to bytes
      base64string = base64.encode(imageBytes); //convert bytes to base64 string
      base64string = "data:image/$imageExtension;base64,$base64string";
    }
    emit(UploadedImageState());
  }

  void writeComment() {
    isCommentPressed = !isCommentPressed;
    emit(WritingCommentState());
  }


  bool isLiked = false;
  void changeLike()
  {
    isLiked = !isLiked;
    emit(WritingCommentState());
  }



}
