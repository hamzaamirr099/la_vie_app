import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:la_vie/core/shared/constants.dart';
import 'package:la_vie/core/utils/bloc/main_layout_bloc/main_cubit.dart';
import 'package:la_vie/core/widgets/default_button.dart';
import 'package:la_vie/features/presentations/cart/screens/cart_screen.dart';
import 'package:la_vie/features/presentations/exam/screens/exam_screen.dart';
import 'package:la_vie/features/presentations/forums/screens/forums_screen.dart';
import 'package:la_vie/features/presentations/home/widgets/category_item.dart';
import 'package:la_vie/features/presentations/home/widgets/product_item.dart';
import 'package:la_vie/features/presentations/profile/screens/profile_screen.dart';
import 'package:la_vie/features/presentations/scan/screens/qr_code_screen.dart';
import 'package:la_vie/features/presentations/search/screens/search_screen.dart';
import 'package:la_vie/models/products_model.dart';
import '../../../../core/utils/bloc/home_bloc/home_cubit.dart';
import '../../../../core/utils/bloc/home_bloc/home_states.dart';
import '../../../../core/utils/network/local/cach_helper.dart';
import '../../../../core/widgets/default_text_form_field_v2.dart';
import '../../notifications/screens/notification_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  List<String> categories = [
    "All",
    "Plants",
    "Seeds",
    "Tools",
  ];

  List<ProductData> listToView = [];

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = HomeCubit.get(context);

    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ExamScreen()));
                    },
                    icon: const Icon(
                      Icons.help_outline,
                      // color: mainAppColor,
                    )),
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                SvgPicture.asset("assets/images/logo.svg"),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: DefaultFormFieldV2(
                        textInputType: TextInputType.none,
                        showCursorFlag: false,
                        onTapFunction: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SearchScreen(listToSearchFrom: homeCubit.productsModel!.data!,)));
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      flex: 1,
                      child: DefaultButton(
                        childWidget: SvgPicture.asset(
                          "assets/images/cart.svg",
                          height: 30.0,
                        ),
                        onPressed: () {
                          debugPrint("Cart");
                          // print(HomeCubit.get(context).cartItemsIds.toString());
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CartScreen(),
                              ));
                        },
                        height: 60.0,
                        borderRadius: 10.0,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Container(
                  height: 40.0,
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => CategoryItem(
                        labelText: categories[index],
                        onTapFunction: () {
                          homeCubit.changeCategoryView(index);
                        }),
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 10.0),
                    itemCount: 4,
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                ConditionalBuilder(
                  condition: HomeCubit.get(context).productsModel != null,
                  builder: (context) {
                    return homeBuilder(context, homeCubit.listToView);
                  },
                  fallback: (context) => Expanded(
                    child: RefreshIndicator(
                      displacement: 50.0,
                      backgroundColor: Colors.white,
                      onRefresh: (){
                        return homeCubit.getAllProducts(token: userToken);
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
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget homeBuilder(context, List<ProductData> listToView) => Expanded(
        child: RefreshIndicator(
          displacement: 50.0,
          backgroundColor: Colors.white,
          onRefresh: () {
            return HomeCubit.get(context).getAllProducts(token: userToken);
          },
          child: GridView.count(
            physics: const BouncingScrollPhysics(),
            mainAxisSpacing: 20.0,
            crossAxisSpacing: 20.0,
            crossAxisCount: 2,
            childAspectRatio: 1 / 1.7,
            children: List.generate(
              listToView.length,
              (index) => ProductItem(
                productData: listToView[index],
              ),
            ),
          ),
        ),
      );
}
