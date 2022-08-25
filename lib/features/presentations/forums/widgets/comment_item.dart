import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:la_vie/models/forum_data_model.dart';

import '../../../../core/shared/constants.dart';

class CommentItem extends StatelessWidget {
  final ForumComments commentItem;
  const CommentItem({Key? key, required this.commentItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String date = DateFormat.MMMMEEEEd().format(
        DateTime.parse("${commentItem.createdAt}"));
    String hourAndMinutes = DateFormat.jm().format(
        DateTime.parse("${commentItem.createdAt}"));
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: mainGreyColor,

      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${commentItem.userId}", style: const TextStyle(color: mainGreenColor, fontWeight: FontWeight.w500),),
            const SizedBox(height: 10,),
            Text("${commentItem.comment}", maxLines: 4, overflow: TextOverflow.ellipsis,),
            const SizedBox(height: 10,),

            Text("$date at $hourAndMinutes", style: const TextStyle(color: Colors.grey),),
          ],
        ),
      ),
    );
  }
}
