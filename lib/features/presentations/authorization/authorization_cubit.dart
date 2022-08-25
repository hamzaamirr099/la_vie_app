import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/shared/components.dart';
import '../../../core/shared/constants.dart';
import '../../../core/utils/network/remote/dio_helper.dart';
import '../../../models/authorization_data_model.dart';
import '../authorization/authorization_states.dart';

class AuthorizationCubit extends Cubit<AuthorizationStates> {
  AuthorizationCubit() : super(InitState());

  static AuthorizationCubit get(context) => BlocProvider.of(context);

  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();

  TextEditingController signUpFirstNameController = TextEditingController();
  TextEditingController signUpLastNameController = TextEditingController();
  TextEditingController signUpEmailController = TextEditingController();
  TextEditingController signUpPasswordController = TextEditingController();
  TextEditingController signUpConfirmPasswordController = TextEditingController();

  AuthorizationDataModel? loginDataModel;
  AuthorizationDataModel? sigUpDataModel;

  // void signUp(String fName, String lName, String email, String password) {
  //
  //   emit(LoadingState());
  //   DioHelper.postData(
  //       url: '/api/v1/auth/signup',
  //       data: {
  //         "firstName" : fName,
  //         "lastName" : lName,
  //         "email" : email,
  //         "password" : password,
  //       },
  //   ).then((value) {
  //     print(value.data);
  //     showToastMessage(message: "User created successfully");
  //     emit(SuccessSignUpState());
  //   }).catchError((error) {
  //     debugPrint(error.toString());
  //     // showToastMessage(message: "Failed to create a user");
  //     emit(FailedSignUpState());
  //   });
  // }

  void signUp(String fName, String lName, String email, String password) async{

    emit(LoadingState());
    try{
      Response value =  await DioHelper.postData(
        url: '/api/v1/auth/signup',
        data: {
          "firstName" : fName,
          "lastName" : lName,
          "email" : email,
          "password" : password,
        },
      );
      print(value.data);
      sigUpDataModel = AuthorizationDataModel.fromJson(value.data);
      showToastMessage(message: "Hello, ${sigUpDataModel!.data!.user!.firstName}");
      emit(SuccessSignUpState(sigUpDataModel!));
      signUpFirstNameController.text = '';
      signUpLastNameController.text = '';
      signUpEmailController.text = '';
      signUpPasswordController.text = '';
      signUpConfirmPasswordController.text = '';

    }on DioError catch(e){
      print(e.response!.data);
      showToastMessage(message: "${e.response!.data['message']}", toastColor: Colors.red);

      emit(FailedSignUpState());
    }


  }

  void login(String email, String password) async{

    emit(LoadingState());
    try{
     Response value =  await DioHelper.postData(
        url: '/api/v1/auth/signin',
        data: {
          "password" : password,
          "email" : email,
        });
     print(value.data);
     loginDataModel = AuthorizationDataModel.fromJson(value.data);

     showToastMessage(message: "Hello, ${loginDataModel!.data!.user!.firstName}");

     emit(SuccessLoginState(loginDataModel!));
     loginEmailController.text = '';
     loginPasswordController.text = '';

    }on DioError catch(e){
      print(e.response!.data);
      showToastMessage(message: "${e.response!.data['message']}", toastColor: Colors.red);

      emit(FailedLoginState());
    }


  }

}
