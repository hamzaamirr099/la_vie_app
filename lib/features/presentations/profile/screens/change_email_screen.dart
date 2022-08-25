import 'package:flutter/material.dart';
import 'package:la_vie/core/shared/constants.dart';
import 'package:la_vie/core/utils/bloc/user_profile_bloc/profile_cubit.dart';
import 'package:la_vie/core/widgets/default_button.dart';
import 'package:la_vie/core/widgets/default_text_form_field.dart';


class ChangeEmailScreen extends StatelessWidget {
  ChangeEmailScreen({Key? key}) : super(key: key);
  TextEditingController emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    ProfileCubit profileCubit = ProfileCubit.get(context);
    emailController.text = profileCubit.userData!.data!.email!;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Update your Email",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
              const SizedBox(
                height: 20.0,
              ),
              DefaultTextFormField(
                controller: emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "This field can't be empty";
                  }
                },
              ),
              const SizedBox(
                height: 20.0,
              ),
              DefaultButton(
                  childWidget: const Text(
                    "Update",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    if(formKey.currentState!.validate())
                      {
                        profileCubit.updateUserEmail(
                          token: userToken,
                          email: emailController.text,
                        );
                        Navigator.pop(context);
                      }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
