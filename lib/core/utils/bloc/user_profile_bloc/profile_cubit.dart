import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie/core/shared/constants.dart';
import 'package:la_vie/core/utils/bloc/user_profile_bloc/profile_states.dart';
import '../../../../models/user_data_model.dart';
import '../../../shared/components.dart';
import '../../network/remote/dio_helper.dart';


class ProfileCubit extends Cubit<ProfileStates> {
  ProfileCubit() : super(InitStateProfileState());

  static ProfileCubit get(context) => BlocProvider.of(context);

  UserDataModel? userData;

  Future<void> getUserData({required String token}) async {
    try {
      Response value = await DioHelper.getData(
        url: '/api/v1/user/me',
        token: token,
      );
      print(value.data);
      showToastMessage(message: "${value.data['message']}");
      userData = UserDataModel.fromJson(value.data);
      emit(SuccessUserDataState());
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
      emit(ErrorUserDataState());
    }
  }

  void updateUserName(
      {required String token,
        required String firstName,
        required String lastName}) async {
    try {
      Response value = await DioHelper.patchData(
        url: '/api/v1/user/me',
        token: token,
        data: {
          "firstName": firstName,
          "lastName": lastName,
        },
      );
      print(value.data);
      showToastMessage(message: "${value.data['message']}");
      //to update the model data
      getUserData(token: userToken);
      emit(SuccessUserNameUpdatedState());
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
      emit(ErrorUserNameUpdatedState());
    }
  }

  void updateUserEmail({required String token, required String email}) async {
    try {
      Response value = await DioHelper.patchData(
        url: '/api/v1/user/me',
        token: token,
        data: {
          "email": email,
        },
      );
      print(value.data);
      showToastMessage(message: "${value.data['message']}");
      //to update the model data
      getUserData(token: userToken);
      emit(SuccessUserEmailUpdatedState());
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
      emit(ErrorUserEmailUpdatedState());
    }
  }


}
