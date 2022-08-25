import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:la_vie/core/utils/network/local/cach_helper.dart';
import 'package:la_vie/core/widgets/default_button.dart';
import 'package:la_vie/core/widgets/default_text_form_field.dart';
import 'package:la_vie/features/presentations/forums/screens/all_comments_screen.dart';
import '../../../../core/shared/constants.dart';
import '../../../../core/utils/bloc/forum_bloc/forum_cubit.dart';
import '../../../../models/forum_data_model.dart';

class ForumPostItem extends StatefulWidget {
  final ForumData forumData;
  TextEditingController commentController = TextEditingController();

  ForumPostItem({Key? key, required this.forumData}) : super(key: key);

  @override
  State<ForumPostItem> createState() => _ForumPostItemState();
}

class _ForumPostItemState extends State<ForumPostItem> {
  bool commentIsClicked = false;

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    bool liked = false;

    ForumCubit forumCubit = ForumCubit.get(context);

    // to know every post that is liked at first
    for (var element in widget.forumData.forumLikes!) {
      if (element.userId == CacheHelper.getData(key: 'userId')) {
        liked = true;
      }

    }
    return InkWell(
      onTap: () {},
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: mainGreyColor),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: widget.forumData.user!.imageUrl ==
                                    null
                                ? const NetworkImage(
                                    "https://res.cloudinary.com/lms07/image/upload/v1645954589/avatar/6214b94ad832b0549b436264_avatar1645954588291.png")
                                : NetworkImage(
                                    "${widget.forumData.user!.imageUrl}"),
                            radius: 30,
                          ),
                          const SizedBox(
                            width: 20.0,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${widget.forumData.user!.firstName} ${widget.forumData.user!.lastName}",
                                  style: const TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w500,
                                      overflow: TextOverflow.ellipsis),
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                const Text(
                                  "a month ago",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        "${widget.forumData.title}",
                        style: const TextStyle(
                            color: mainGreenColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            overflow: TextOverflow.ellipsis),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        "${widget.forumData.description}",
                        maxLines: 3,
                        style: const TextStyle(
                            color: Colors.grey,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                widget.forumData.imageUrl == null
                    ? Image.asset("assets/images/no_image_found.png")
                    : Image.network(
                        "$baseUrl${widget.forumData.imageUrl}",
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 300,
                      ),
              ],
            ),
          ),
          // const SizedBox(
          //   height: 10.0,
          // ),
          commentIsClicked
              ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Form(
                      key: formKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: DefaultTextFormField(
                          controller: widget.commentController,
                          hintText: "Write a comment",
                          suffixWidget: Container(
                            height: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: mainGreenColor
                            ),
                            child: TextButton(
                              onPressed: () {
                                commentIsClicked = false;
                                if (formKey.currentState!.validate()) {
                                  forumCubit.commentOnPost(
                                      token: userToken,
                                      data: {"comment": widget.commentController.text},
                                      forumId: widget.forumData.forumId);
                                }

                              },
                            child: const Text("Comment" , style: TextStyle(color: Colors.white),),),
                          ),

                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter your comment';
                            }
                          },

                        ),
                      ),
                    ),
                  DefaultButton(childWidget: Text("Show all comments", style: TextStyle(color: Colors.white),), onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>AllCommentsScreen(comments: widget.forumData.forumComments!,)));
                  })
                ],
              )
              : Container(),
          // const SizedBox(
          //   height: 10.0,
          // ),
          Row(
            children: [
              IconButton(
                onPressed: () {

                    for(var item in widget.forumData.forumLikes!)
                      {
                        if (item.userId == CacheHelper.getData(key: 'userId')) {
                          setState(() {
                            liked = false;

                          });
                        }
                      }
                  debugPrint("like");

                    forumCubit.likePost(
                      token: userToken,
                      data: {},
                      forumId: widget.forumData.forumId);
                  // ForumCubit.get(context).changeLike();
                },
                icon: liked
                    ? const Icon(
                        Icons.thumb_up,
                        color: mainGreenColor,
                      )
                    : const Icon(
                        Icons.thumb_up_alt_outlined,
                        color: Colors.black,
                      ),
              ),
              const SizedBox(
                width: 5.0,
              ),
              Text("${widget.forumData.forumLikes!.length} likes"),
              const SizedBox(
                width: 50.0,
              ),
              InkWell(
                  onTap: () {
                    // ForumCubit.get(context).writeComment();
                    setState(() {
                      print("is clicked");
                      commentIsClicked = !commentIsClicked;
                    });
                  },
                  child: Text(
                      "${widget.forumData.forumComments!.length} replies")),
            ],
          ),
        ],
      ),
    );
  }
}
