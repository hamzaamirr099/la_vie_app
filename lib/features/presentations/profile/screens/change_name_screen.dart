import 'package:flutter/material.dart';
import 'package:la_vie/core/shared/constants.dart';
import 'package:la_vie/core/widgets/default_button.dart';
import 'package:la_vie/core/widgets/default_text_form_field.dart';

import '../../../../core/utils/bloc/home_bloc/home_cubit.dart';
import '../../../../core/utils/bloc/user_profile_bloc/profile_cubit.dart';
import '../../../../core/utils/network/local/cach_helper.dart';

class ChangeNameScreen extends StatelessWidget {
  ChangeNameScreen({Key? key}) : super(key: key);
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    ProfileCubit profileCubit = ProfileCubit.get(context);
    firstNameController.text = profileCubit.userData!.data!.firstName!;
    lastNameController.text = profileCubit.userData!.data!.lastName!;

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
                "Update your name",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
              const SizedBox(
                height: 20.0,
              ),
              DefaultTextFormField(
                controller: firstNameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "This field can't be empty";
                  }
                },
              ),
              const SizedBox(
                height: 20.0,
              ),
              DefaultTextFormField(
                controller: lastNameController,
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
                    if (formKey.currentState!.validate()) {
                      profileCubit.updateUserName(
                        token: userToken,
                        firstName: firstNameController.text,
                        lastName: lastNameController.text,
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
