import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie/core/shared/constants.dart';
import 'package:la_vie/core/utils/network/local/cach_helper.dart';
import 'package:la_vie/core/widgets/default_button.dart';
import 'package:la_vie/core/widgets/default_text_form_field_v2.dart';
import 'package:la_vie/features/presentations/forums/screens/create_post_screen.dart';
import 'package:la_vie/features/presentations/forums/screens/serach_for_forum.dart';
import 'package:la_vie/features/presentations/forums/widgets/forum_post_item.dart';

import '../../../../core/utils/bloc/forum_bloc/forum_cubit.dart';
import '../../../../core/utils/bloc/forum_bloc/forum_states.dart';

class ForumScreen extends StatelessWidget {
  const ForumScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ForumCubit cubit = ForumCubit.get(context);
    cubit.getAllForums(token: userToken);
    return BlocConsumer<ForumCubit, ForumStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(),
          floatingActionButton: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
            child: FloatingActionButton(
              heroTag: "createPostBtn",
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => CreatePostScreen()));
              },
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Discussion Forums", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20.0),),
                const SizedBox(height: 20.0,),

                DefaultFormFieldV2(
                  textInputType: TextInputType.none,
                  showCursorFlag: false,
                  onTapFunction: () {
                    cubit.searchResult = [];
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SearchForForumScreen()));
                  },
                  hintText: "Search",
                  prefixIcon: Icons.search,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    Expanded(
                        child: DefaultButton(
                      backgrounColor:
                          cubit.allForumsButton ? mainGreenColor : Colors.white,
                      childWidget: Text(
                        "All Forums",
                        style: TextStyle(
                            color: cubit.allForumsButton
                                ? Colors.white
                                : Colors.grey),
                      ),
                      onPressed: () {
                        if (!cubit.allForumsButton) {
                          cubit.switchAllForumsAndMyForums();
                          print(cubit.allForumsButton);
                        }
                      },
                    )),
                    const SizedBox(
                      width: 20.0,
                    ),
                    Expanded(
                        child: DefaultButton(
                      backgrounColor:
                          cubit.allForumsButton ? Colors.white : mainGreenColor,
                      childWidget: Text(
                        "My Forums",
                        style: TextStyle(
                            color: cubit.allForumsButton
                                ? Colors.grey
                                : Colors.white),
                      ),
                      onPressed: () {
                        if (cubit.allForumsButton) {
                          cubit.switchAllForumsAndMyForums();
                          print(cubit.allForumsButton);
                        }
                      },
                      width: 50.0,
                    )),
                    const Spacer(),
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),
                cubit.allForumsButton
                    ? ConditionalBuilder(
                        condition: cubit.allForums != null,
                        builder: (context) {
                          return Expanded(
                            child: RefreshIndicator(
                              displacement: 50.0,
                              backgroundColor: Colors.white,
                              onRefresh: (){
                                return cubit.getAllForums(token: userToken);
                              },
                              child: ListView.separated(
                                  physics: const BouncingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return ForumPostItem(
                                      forumData: cubit.allForums!.data![index],
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return const SizedBox(
                                      height: 50.0,
                                    );
                                  },
                                  //mainCubit.userForums!.data!.length
                                  itemCount: cubit.allForums!.data!
                                      .length //here will be the length of the array of the notifications
                                  ),
                            ),
                          );
                        },
                        fallback: (context) => Expanded(
                          child: RefreshIndicator(
                            displacement: 50.0,
                            backgroundColor: Colors.white,
                            onRefresh: (){
                              return cubit.getAllForums(token: userToken);
                            },
                            child: ListView(
                              // physics: BouncingScrollPhysics(),
                              children:
                              [
                                SizedBox(height: MediaQuery.of(context).size.height/4,),
                                const Center(child: CircularProgressIndicator()),
                              ],
                            ),
                          ),
                        ),
                      )
                    : ConditionalBuilder(
                        condition: cubit.userForums.isNotEmpty,
                        builder: (context) {
                          return Expanded(
                            child: RefreshIndicator(
                              displacement: 50.0,
                              backgroundColor: Colors.white,
                              onRefresh: (){
                                return cubit.getAllForums(token: userToken);
                              },
                              child: ListView.separated(
                                  physics: const BouncingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return ForumPostItem(
                                      forumData: cubit.userForums[index],
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return const SizedBox(
                                      height: 50.0,
                                    );
                                  },
                                  itemCount: cubit.userForums
                                      .length //here will be the length of the array of the notifications
                                  ),
                            ),
                          );
                        },
                        fallback: (context) => const Expanded(
                            child: Center(
                          child: Text(
                            "No Forums yet",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        )),
                      ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// class ForumScreen extends StatefulWidget {
//   ForumScreen({Key? key}) : super(key: key);
//
//   @override
//   State<ForumScreen> createState() => _ForumScreenState();
// }
//
// class _ForumScreenState extends State<ForumScreen>
// {
//   bool allForums = true;
//   @override
//   Widget build(BuildContext context) {
//     ForumCubit cubit = ForumCubit.get(context);
//     cubit.getUserForums(CacheHelper.getData(key: 'userToken'));
//     return BlocConsumer<ForumCubit, ForumStates>(
//       listener: (context, state) {},
//       builder: (context, state) {
//         return Scaffold(
//           appBar: AppBar(
//             title: Text("Discussion Forums"),
//           ),
//           body: Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: Column(
//               children: [
//                 DefaultFormFieldV2(
//                   hintText: "Serach",
//                   prefixIcon: Icons.search,
//                 ),
//                 SizedBox(height: 20.0,),
//                 Row(
//                   children: [
//                     Expanded(
//                         child: DefaultButton(
//                           backgrounColor: allForums ? mainGreenColor : Colors.white,
//                           childWidget: Text(
//                             "All Forums",
//                             style: TextStyle(
//                                 color: allForums ? Colors.white : Colors.grey),
//                           ),
//                           onPressed: () {
//                             setState(() {
//                               if (!allForums) {
//                                 allForums = !allForums;
//                               }
//                             });
//                           },
//                         )),
//                     SizedBox(
//                       width: 20.0,
//                     ),
//                     Expanded(
//                         child: DefaultButton(
//                           backgrounColor: allForums ? Colors.white : mainGreenColor,
//                           childWidget: Text(
//                             "My Forums",
//                             style: TextStyle(
//                                 color: allForums ? Colors.grey : Colors.white),
//                           ),
//                           onPressed: () {
//                             setState(() {
//                               if (allForums) {
//                                 allForums = !allForums;
//                               }
//                             });
//                           },
//                           width: 50.0,
//                         )),
//                     Spacer(),
//                   ],
//                 ),
//                 SizedBox(height: 20.0,),
//
//                 ConditionalBuilder(
//                   condition: cubit.userForums != null,
//                   builder: (context) {return Expanded(
//                     child: ListView.separated(
//                       physics: const BouncingScrollPhysics(),
//                       itemBuilder: (context, index) {
//                         return ForumPostItem(forumData: cubit.userForums!.data![index],);
//                       },
//                       separatorBuilder: (context, index)
//                       {
//                         return SizedBox(height: 50.0,);
//                       },
//                       //mainCubit.userForums!.data!.length
//                       itemCount: cubit.userForums!.data!.length, //here will be the length of the array of the notifications
//                     ),
//                   );},
//                   fallback: (context) => Center(child: CircularProgressIndicator(),),
//                 ),
//
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
