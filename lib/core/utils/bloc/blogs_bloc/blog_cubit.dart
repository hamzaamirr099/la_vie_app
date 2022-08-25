import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie/core/utils/bloc/blogs_bloc/blog_states.dart';
import 'package:la_vie/models/plant_model.dart';

import '../../../shared/components.dart';
import '../../network/remote/dio_helper.dart';


class BlogCubit extends Cubit<BlogStates> {
  BlogCubit() : super(InitBlogState());

  static BlogCubit get(context) => BlocProvider.of(context);

  List<PlantModel> allBlogs = [];

  Future<void> getAllBlogs({required String token}) async {
    allBlogs = [];
    try {
      Response value = await DioHelper.getData(
          url: '/api/v1/products/blogs', token: token);
      showToastMessage(message: "${value.data['message']}");
      for(var element in value.data['data']['plants'])
        {
          allBlogs.add(PlantModel.fromJson(element));
        }

      emit(SuccessFetchBlogsState());
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
      emit(ErrorFetchBlogsState());
    }
  }

}
