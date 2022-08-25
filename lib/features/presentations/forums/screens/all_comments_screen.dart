import 'package:flutter/material.dart';
import 'package:la_vie/features/presentations/forums/widgets/comment_item.dart';
import 'package:la_vie/models/forum_data_model.dart';

class AllCommentsScreen extends StatelessWidget {
  final List<ForumComments> comments;
  const AllCommentsScreen({Key? key, required this.comments}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: CommentItem(commentItem: comments[index]),
                );
              },
              itemCount: comments.length, //here will be the length of the array of the notifications
            ),
          ),
        ],

      ),
    );
  }
}
