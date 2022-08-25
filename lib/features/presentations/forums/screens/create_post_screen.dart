import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie/core/shared/components.dart';
import 'package:la_vie/core/shared/constants.dart';
import '../../../../core/utils/bloc/forum_bloc/forum_cubit.dart';
import '../../../../core/utils/bloc/forum_bloc/forum_states.dart';
import '../../../../core/widgets/default_button.dart';
import '../../../../core/widgets/default_text_form_field.dart';

class CreatePostScreen extends StatelessWidget {
  CreatePostScreen({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ForumCubit cubit = ForumCubit.get(context);
    cubit.base64string = "";
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Create New post",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(color: mainGreenColor)),
                  child: InkWell(
                    onTap: () async {
                      await cubit.uploadImage();
                    },
                    child: BlocConsumer<ForumCubit, ForumStates>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        return Padding(
                          padding: const EdgeInsets.all(30),
                          child: cubit.base64string.isEmpty ? Column(
                            children: const [
                              Icon(Icons.add),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                "Add photo",
                                style: TextStyle(color: mainGreenColor),
                              ),
                            ],
                          ) :Column(
                            children: const [
                              Icon(Icons.check),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                "Uploaded Successfully",
                                style: TextStyle(color: mainGreenColor),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Title"),
                    const SizedBox(height: 5.0),
                    DefaultTextFormField(
                      controller: titleController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter email';
                        }
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text("Description"),
                    const SizedBox(height: 5.0),
                    DefaultTextFormField(
                      controller: descriptionController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter email';
                        }
                      },
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    DefaultButton(
                      height: 50,
                      borderRadius: 10,
                      childWidget: const Text(
                        "Post",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          if (cubit.base64string.isNotEmpty) {
                            cubit.createPost(
                                token: userToken,
                                data: {
                                  "title": titleController.text,
                                  "description": descriptionController.text,
                                  "imageBase64": cubit.base64string,
                                });
                            Navigator.pop(context);
                          }
                          else{
                            showToastMessage(message: "Upload an image first", toastColor: Colors.red);
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
