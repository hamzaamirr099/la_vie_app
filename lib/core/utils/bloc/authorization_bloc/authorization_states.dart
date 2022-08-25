import 'package:la_vie/models/authorization_data_model.dart';

abstract class AuthorizationStates {}

class InitState extends AuthorizationStates {}
class LoadingState extends AuthorizationStates {}
class SuccessLoginState extends AuthorizationStates {
  late AuthorizationDataModel authorizationDataModel;
  SuccessLoginState(this.authorizationDataModel);

}
class FailedLoginState extends AuthorizationStates {}
class SuccessSignUpState extends AuthorizationStates {
  late AuthorizationDataModel authorizationDataModel;
  SuccessSignUpState(this.authorizationDataModel);
}
class FailedSignUpState extends AuthorizationStates {}



