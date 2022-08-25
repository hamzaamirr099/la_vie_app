import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:la_vie/core/shared/constants.dart';
import 'package:la_vie/core/widgets/default_button.dart';
import 'package:la_vie/features/presentations/cart/widgets/cart_item.dart';
import '../../../../core/utils/bloc/cart_bloc/cart_cubit.dart';
import '../../../../core/utils/bloc/cart_bloc/cart_states.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // CacheHelper.getData(key: 'cartItems') != null ? HomeCubit.get(context).cartItemsIds = CacheHelper.getData(key: 'cartItems') : HomeCubit.get(context).cartItemsIds = [];

    CartCubit cartCubit = CartCubit.get(context);
    cartCubit.calculateTotalPrice(); //to sum all product prices
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90.0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              size: 30.0,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            color: Colors.black,
          ),
        ),
        title: const Text(
          "My Cart",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20.0),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          BlocConsumer<CartCubit, CartStates>(
            listener: (context, state) {},
            builder: (context, state) {
              return ConditionalBuilder(
                condition: cartCubit.allCartItems.isNotEmpty,
                builder: (context) => Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return CartItem(
                                item: cartCubit.allCartItems[index]);
                          },
                          itemCount: cartCubit.allCartItems
                              .length, //here will be the length of the array of the notifications
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          children: [
                            const Text(
                              "Total",
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.w600),
                            ),
                            const Spacer(),
                            Text(
                              "${cartCubit.totalPrice} EGP",
                              style: const TextStyle(
                                  color: mainGreenColor,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: DefaultButton(
                          childWidget: const Text(
                            "Checkout",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {},
                          height: 50.0,
                          borderRadius: 10.0,
                        ),
                      )
                    ],
                  ),
                ),
                fallback: (context) => Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: Column(
                      children: [
                        SvgPicture.asset("assets/images/emptyCart.svg"),
                        const SizedBox(
                          height: 15.0,
                        ),
                        const Text(
                          "Your cart is empty",
                          style: TextStyle(
                              fontSize: 30.0, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
