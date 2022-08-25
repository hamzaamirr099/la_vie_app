import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie/core/shared/constants.dart';
import 'package:la_vie/core/utils/bloc/user_profile_bloc/profile_cubit.dart';
import 'package:la_vie/core/utils/bloc/user_profile_bloc/profile_states.dart';
import 'package:la_vie/features/presentations/notifications/widgets/notification_item.dart';
class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProfileCubit profileCubit = ProfileCubit.get(context);
    profileCubit.getUserData(token: userToken);
    return BlocConsumer<ProfileCubit, ProfileStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              const Text("Notifications", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20.0),),
              const SizedBox(height: 20.0,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ConditionalBuilder(
                      condition: profileCubit.userData != null, //we should check if the notification array is not empty
                      builder: (context) => Expanded(
                        child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return NotificationItem(notificationItem: profileCubit.userData!.data!.userNotification![index],);
                          },
                          separatorBuilder: (context, index) {
                            return Container(
                              width: double.infinity,
                              color: const Color.fromRGBO(221, 222, 225, 1),
                              height: 1.0,
                            );
                          },
                          itemCount: profileCubit.userData!.data!.userNotification!.length, //here will be the length of the array of the notifications
                        ),
                      ),
                      fallback: (context) => const Expanded(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
