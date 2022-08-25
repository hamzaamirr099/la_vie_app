import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie/core/utils/bloc/main_layout_bloc/main_states.dart';
import 'package:flutter/material.dart';
import 'package:la_vie/features/presentations/forums/screens/forums_screen.dart';
import 'package:la_vie/features/presentations/home/screens/home_screen.dart';
import '../../../../features/presentations/notifications/screens/notification_screen.dart';
import '../../../../features/presentations/profile/screens/profile_screen.dart';
import '../../../../features/presentations/scan/screens/qr_code_screen.dart';
import '../../../shared/constants.dart';
import '../cart_bloc/cart_cubit.dart';
import '../forum_bloc/forum_cubit.dart';
import '../home_bloc/home_cubit.dart';
import '../user_profile_bloc/profile_cubit.dart';


class MainCubit extends Cubit<MainStates> {
  MainCubit() : super(InitState());

  static MainCubit get(context) => BlocProvider.of(context);


  List<Widget> screens = [
    ForumScreen(),
    ScanScreen(),
    NotificationsScreen(),
    ProfileScreen(),
    HomeScreen(),
  ];

  int activeBottomNavBarIndex = 4;

  int flagForFetchFromShared = 0;//this flag to get cart items from shared one time only at first

  //fetch data
  void initialization(BuildContext context)
  {
    HomeCubit.get(context).getAllProducts(token: userToken);
    ForumCubit.get(context).getAllForums(token: userToken);
    if(flagForFetchFromShared == 0) {
      CartCubit.get(context).getCartItemsFromShared();
      flagForFetchFromShared = 1;
    }

  }
  void changeBottomNavBar(int index)
  {
    activeBottomNavBarIndex = index;
    emit(BottomNavBarChangeState());
  }

}
