import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../models/user_data_model.dart';

class NotificationItem extends StatelessWidget {
  final NotificationData notificationItem;


  const NotificationItem({Key? key, required this.notificationItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //get the name of the user that make the notification from the message of the notification
    String notificationMessage = notificationItem.message!;
    int index = notificationMessage.indexOf(' ');
    index = notificationMessage.indexOf(' ', index + 1);
    String nameOfUser = notificationMessage.substring(0, index);

    String date = DateFormat.MMMMEEEEd().format(
        DateTime.parse("${notificationItem.createdAt}"));
    String hourAndMinutes = DateFormat.jm().format(
        DateTime.parse("${notificationItem.createdAt}"));


    return InkWell(
      onTap: (){
        print(notificationItem.userId);
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundImage: notificationItem.imageUrl == "" ? const NetworkImage(
                      "https://res.cloudinary.com/lms07/image/upload/v1645954589/avatar/6214b94ad832b0549b436264_avatar1645954588291.png")
                  : NetworkImage(notificationItem.imageUrl!),
              radius: 20.0,
            ),
            const SizedBox(
              width: 10.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    nameOfUser,
                    style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        overflow: TextOverflow.ellipsis),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          width: 3.0,
                          height: 10.0,
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Expanded(
                          child: Text(
                            "${notificationItem.message}",
                            style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                overflow: TextOverflow.ellipsis),
                            maxLines: 4,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    "$date at $hourAndMinutes",
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
