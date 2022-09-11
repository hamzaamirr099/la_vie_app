import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:la_vie/core/utils/bloc/main_layout_bloc/main_cubit.dart';
import 'package:la_vie/core/utils/bloc/main_layout_bloc/main_states.dart';
import '../../../core/shared/constants.dart';


class MainLayout extends StatelessWidget {
  const MainLayout({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    MainCubit mainCubit = MainCubit.get(context);
    if(mainCubit.activeBottomNavBarIndex != 4) {
      mainCubit.changeBottomNavBar(4);
    }
    //fetch all important data at first
    mainCubit.initialization(context);// must handle this to not call if offline

    return BlocConsumer<MainCubit, MainStates>(
      listener: (context, state) {},
      builder: (context, state) {

        return Builder(
          builder: (BuildContext context) {
            return Scaffold(

              floatingActionButton: FloatingActionButton(
                heroTag: "homeBtn",
                onPressed: () {
                  mainCubit.changeBottomNavBar(4);

                },
                child: SvgPicture.asset("assets/images/homeLogo.svg"),

                //params
              ),
              floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
              bottomNavigationBar: AnimatedBottomNavigationBar(
                notchSmoothness: NotchSmoothness.smoothEdge,

                icons: const [
                  Icons.description_outlined,
                  Icons.qr_code_scanner,
                  Icons.notifications_none_outlined,
                  Icons.account_circle_outlined,
                ],
                activeIndex: mainCubit.activeBottomNavBarIndex,
                gapLocation: GapLocation.center,
                inactiveColor: Colors.black,
                activeColor: mainGreenColor,

                onTap: (index) {
                  debugPrint(index.toString());
                  mainCubit.changeBottomNavBar(index);
                },

                //other params
              ),
              body: mainCubit.screens[mainCubit.activeBottomNavBarIndex],
            );
          },
        );

      },
    );
  }
}
