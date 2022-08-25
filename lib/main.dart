import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:la_vie/core/utils/bloc/blogs_bloc/blog_cubit.dart';
import 'package:la_vie/core/utils/bloc/main_layout_bloc/main_cubit.dart';
import 'package:la_vie/core/utils/bloc/user_profile_bloc/profile_cubit.dart';
import 'package:la_vie/features/presentations/authorization/screens/authorization_screen.dart';
import 'package:la_vie/features/presentations/blogs/screens/blog_screen.dart';
import 'package:la_vie/features/presentations/forums/screens/forums_screen.dart';
import 'package:la_vie/features/presentations/splash/splash_screen.dart';
import 'core/shared/constants.dart';
import 'core/utils/bloc/cart_bloc/cart_cubit.dart';
import 'core/utils/bloc/forum_bloc/forum_cubit.dart';
import 'core/utils/bloc/home_bloc/home_cubit.dart';
import 'core/utils/network/local/cach_helper.dart';
import 'core/utils/network/remote/dio_helper.dart';
import 'features/presentations/main_app_layout/main_layout_screen.dart';


void main() async{
  WidgetsFlutterBinding
      .ensureInitialized();
  await CacheHelper.init();
  DioHelper.init();
  if(CacheHelper.getData(key: 'userToken') == null) {
    userToken = '';
  } else if(CacheHelper.getData(key: 'userToken') == '') {
    userToken = '';
  } else {
    userToken = CacheHelper.getData(key: 'userToken');
  }

  // userToken = CacheHelper.getData(key: 'userToken');
  print("the token is $userToken");
  runApp(const MyApp());

}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeCubit>(
            create: (context) => HomeCubit(),
        ),
        BlocProvider<ForumCubit>(
            create: (context) => ForumCubit(),
        ),
        BlocProvider<CartCubit>(
            create: (context) => CartCubit(),
        ),
        BlocProvider<MainCubit>(
            create: (context) => MainCubit(),
        ),
        BlocProvider<ProfileCubit>(
            create: (context) => ProfileCubit(),
        ),
        BlocProvider<BlogCubit>(
            create: (context) => BlogCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: mainGreenColor),
          appBarTheme: const AppBarTheme( backgroundColor: Colors.white, elevation: 0.0, iconTheme: IconThemeData(color: Colors.black)),
          primarySwatch: mainGreenColor,
          tabBarTheme: const TabBarTheme(labelColor: mainGreenColor, unselectedLabelColor: Colors.grey),
          progressIndicatorTheme: const ProgressIndicatorThemeData(refreshBackgroundColor: Colors.white, )
        ),

        //userToken == ''? const AuthorizationScreen() : const HomeScreen()
        home:SplashScreen()
      ),
    );
  }

}

