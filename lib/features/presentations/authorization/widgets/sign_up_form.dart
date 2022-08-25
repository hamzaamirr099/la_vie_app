import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:la_vie/core/shared/components.dart';
import 'package:la_vie/features/presentations/main_app_layout/main_layout_screen.dart';
import '../../../../core/shared/constants.dart';
import '../../../../core/utils/network/local/cach_helper.dart';
import '../../../../core/widgets/default_button.dart';
import '../../../../core/widgets/default_text_form_field.dart';
import '../../authorization/authorization_states.dart';
import '../authorization_cubit.dart';

class SignUpForm extends StatelessWidget {
  SignUpForm({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthorizationCubit, AuthorizationStates>(
      listener: (context, state) async {
        if(state is SuccessSignUpState)
        {
          //will save token in shared pref here, then navigate to the home screen
          userToken = state.authorizationDataModel.data!.accessToken!;
          await CacheHelper.saveData(key: 'userToken', value: state.authorizationDataModel.data!.accessToken);
          await CacheHelper.saveData(key: 'userId', value: state.authorizationDataModel.data!.user!.userId);

          navigateAndRelease(context, const MainLayout());

        }
      },
      builder: (context, state) {
        var cubit = AuthorizationCubit.get(context);
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 45.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("First name"),
                  const SizedBox(
                      height: 3.8
                  ),
                  DefaultTextFormField(
                    validator: (value)
                    {
                      if(value == null || value.isEmpty) {
                        return 'Please enter your first name';
                      }

                    },
                    controller: cubit.signUpFirstNameController,
                  ),
                  const SizedBox(
                      height: 20
                  ),
                  const Text("Last name"),
                  const SizedBox(
                      height: 3.8
                  ),
                  DefaultTextFormField(
                    validator: (value)
                    {
                      if(value == null || value.isEmpty) {
                        return 'Please enter your last name';
                      }

                    },
                    controller: cubit.signUpLastNameController,
                  ),
                  const SizedBox(
                      height: 20
                  ),
                  const Text("Email"),
                  const SizedBox(
                      height: 3.8
                  ),
                  DefaultTextFormField(
                    validator: (value)
                    {
                      if(value == null || value.isEmpty) {
                        return 'Please enter email';
                      }

                    },
                    controller: cubit.signUpEmailController,
                  ),
                  const SizedBox(
                      height: 20
                  ),
                  const Text("Password"),
                  const SizedBox(
                      height: 3.8
                  ),
                  DefaultTextFormField(
                    validator: (value)
                    {
                      if(value == null || value.isEmpty) {
                        return 'Please enter password';
                      }

                    },
                    controller: cubit.signUpPasswordController,
                  ),
                  const SizedBox(
                      height: 20
                  ),
                  const Text("Confirm password"),
                  const SizedBox(
                      height: 3.8
                  ),
                  DefaultTextFormField(
                    validator: (value)
                    {
                      if(value == null || value.isEmpty) {
                        return 'Please confirm your password';
                      }

                    },
                    controller: cubit.signUpConfirmPasswordController,
                  ),
                  const SizedBox(
                      height: 30
                  ),
                  DefaultButton(
                    childWidget: const Text("Sign up", style: TextStyle(color: Colors.white),),
                    onPressed: () {
                      debugPrint("pressed");
                      if(formKey.currentState!.validate())
                        {
                          if(cubit.signUpPasswordController.text == cubit.signUpConfirmPasswordController.text)
                            {
                              cubit.signUp(
                                cubit.signUpFirstNameController.text,
                                cubit.signUpLastNameController.text,
                                cubit.signUpEmailController.text,
                                cubit.signUpPasswordController.text,
                              );
                            }
                          else{
                            showToastMessage(message: "Your confirmation password is not match");
                          }

                        }

                    },
                  ),
                  const SizedBox(height: 20,),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 1.0,
                          color: const Color.fromRGBO(151, 151, 151, 1),
                        ),
                      ),
                      const Text(
                        "  Or continue with  ",
                        style: TextStyle(color: Color.fromRGBO(151, 151, 151, 1)),
                      ),
                      Expanded(
                        child: Container(
                          height: 1.0,
                          color: const Color.fromRGBO(151, 151, 151, 1),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: SvgPicture.asset(
                          'assets/images/google.svg',
                        ),
                        onPressed: (){}, //do something,
                      ),
                      IconButton(
                        icon: SvgPicture.asset(
                          'assets/images/facebook.svg',
                        ),
                        onPressed: (){}, //do something,
                      ),
                    ],
                  ),
                  const SizedBox(height: 140.0,),


                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
