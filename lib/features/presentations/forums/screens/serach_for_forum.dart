import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie/core/shared/constants.dart';
import 'package:la_vie/core/widgets/default_text_form_field_v2.dart';
import '../../../../core/utils/bloc/forum_bloc/forum_cubit.dart';
import '../../../../core/utils/bloc/forum_bloc/forum_states.dart';
import '../widgets/forum_post_item.dart';

class SearchForForumScreen extends StatelessWidget {
  const SearchForForumScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ForumCubit cubit = ForumCubit.get(context);
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            DefaultFormFieldV2(
              onFieldSubmitted: (value) {
                cubit.searchForForums(token:
                    userToken, searchString: value!.toLowerCase());
              },
            ),
            const SizedBox(height: 20.0,),
            BlocConsumer<ForumCubit ,ForumStates>(
              listener: (context, state) {},
              builder: (context, state) {
                return  ConditionalBuilder(
                    condition: state is! LoadingState,
                    builder: (context) => ConditionalBuilder(
                      condition: cubit.searchResult.isNotEmpty,
                      builder: (context) {
                        return Expanded(
                          child: ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return ForumPostItem(
                                  forumData: cubit.searchResult[index],
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const SizedBox(
                                  height: 50.0,
                                );
                              },
                              //mainCubit.userForums!.data!.length
                              itemCount: cubit.searchResult
                                  .length //here will be the length of the array of the notifications
                          ),
                        );
                      },
                      fallback: (context) => const Expanded(
                        child: Center(
                          child: Text(
                            "No search result",
                            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    fallback:(context) => Expanded(child: const Center(child: CircularProgressIndicator()))
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
