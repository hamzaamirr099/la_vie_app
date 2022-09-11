import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:la_vie/core/shared/components.dart';
import 'package:la_vie/core/shared/constants.dart';
import 'package:la_vie/core/utils/bloc/main_layout_bloc/main_cubit.dart';
import 'package:la_vie/core/utils/bloc/user_profile_bloc/profile_states.dart';
import 'package:la_vie/core/utils/network/local/cach_helper.dart';
import 'package:la_vie/core/widgets/default_button.dart';
import 'package:la_vie/features/presentations/authorization/screens/authorization_screen.dart';
import 'package:la_vie/features/presentations/blogs/screens/blog_screen.dart';
import 'package:la_vie/features/presentations/profile/screens/change_email_screen.dart';
import 'package:la_vie/features/presentations/profile/screens/change_name_screen.dart';
import 'package:la_vie/features/presentations/profile/widgets/edit_profile_option.dart';
import '../../../../core/utils/bloc/user_profile_bloc/profile_cubit.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProfileCubit profileCubit = ProfileCubit.get(context);
    profileCubit.getUserData(token: userToken);
    int? userPoints = 0;
    if (profileCubit.userData != null &&
        profileCubit.userData!.data!.userPoints != null) {
      userPoints = profileCubit.userData!.data!.userPoints;
    }

    return BlocConsumer<ProfileCubit, ProfileStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: profileCubit.userData != null,
          builder: (context) => Scaffold(
            backgroundColor: Colors.grey[800],
            body: Column(
              children: [
                Stack(
                  children: [
                    Opacity(
                      opacity: 0.8,
                      child: Image.network(
                        "${profileCubit.userData!.data!.imageUrl}",
                        width: double.infinity,
                        fit: BoxFit.fitHeight,
                        height: 300,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 300,
                      color: Colors.black.withOpacity(0.6),
                    ),
                    Column(
                      children: [
                        SafeArea(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      // navigateAndRelease(context, MainLayout());
                                      MainCubit.get(context).changeBottomNavBar(
                                          4); // change the navBar to the home screen
                                    },
                                    icon: const Icon(
                                      Icons.arrow_back,
                                      color: Colors.white,
                                      size: 30.0,
                                    )),
                                const Spacer(),
                                IconButton(
                                    onPressed: () {
                                      CacheHelper.removeAllSharedData();
                                      // profileCubit.userData = null;
                                      debugPrint("logged out");
                                      navigateAndRelease(
                                          context, AuthorizationScreen());
                                    },
                                    icon: const Icon(
                                      Icons.logout,
                                      color: Colors.white,
                                      size: 30,
                                    )),
                              ],
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            const Spacer(),
                            Column(
                              children: [
                                CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      "${profileCubit.userData!.data!.imageUrl}"),
                                  radius: 65.0,
                                ),
                                const SizedBox(
                                  height: 15.0,
                                ),
                                Text(
                                  "${profileCubit.userData!.data!.firstName} ${profileCubit.userData!.data!.lastName}",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22.0),
                                ),
                              ],
                            ),
                            const Spacer(),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0)),
                      // color: Colors.red,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            height: 80.0,
                            decoration: BoxDecoration(
                              color: Colors.green.withOpacity(.1),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                      "assets/images/pointsLogo.svg"),
                                  const SizedBox(
                                    width: 10.0,
                                  ),
                                  Text(
                                    "You have $userPoints points",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                          const Text(
                            "Edit Profile",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 25.0),
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                          EditProfileOption(
                            option: "Change Name",
                            onTapFunction: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ChangeNameScreen()));
                            },
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                          EditProfileOption(
                            option: "Change Email",
                            onTapFunction: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ChangeEmailScreen()));
                            },
                          ),
                          // Spacer(),
                          const SizedBox(
                            height: 30.0,
                          ),

                          Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: DefaultButton(
                                // width: 100,
                                childWidget: const Text(
                                  "Go to blogs",
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => BlogsScreen()));
                                }),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
