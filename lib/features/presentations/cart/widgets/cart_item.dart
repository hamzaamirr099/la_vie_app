import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie/core/utils/bloc/cart_bloc/cart_states.dart';
import 'package:la_vie/models/products_model.dart';
import '../../../../core/shared/constants.dart';
import '../../../../core/utils/bloc/cart_bloc/cart_cubit.dart';


class CartItem extends StatelessWidget {

  final ProductData item;
  const CartItem({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 10,
              offset: const Offset(0, 5), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              Image.network(
                '$baseUrl${item.imageUrl}',
                fit: BoxFit.contain,
                width: 100,
                height: 100,
              ),
              const SizedBox(
                width: 20.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${item.name}",
                      maxLines: 2,
                      style:
                      const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, overflow: TextOverflow.ellipsis),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      '${item.price} EGP',
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: mainGreenColor),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.grey[100],
                          ),
                          child: Row(
                            children: [
                              IconButton(onPressed: (){

                                if(item.amount <= 1)
                                    {
                                      item.amount = 1;
                                    }
                                    else {
                                  item.amount --;
                                  CartCubit.get(context).changedAmountOfProduct();
                                  CartCubit.get(context).calculateTotalPrice();

                                }

                              },
                                icon: const Icon(Icons.remove),),
                              BlocConsumer<CartCubit, CartStates>(
                                listener: (context, state){},
                                builder: (context, state){
                                  return  Text(
                                      "${item.amount}");
                                },
                              ),
                              IconButton(onPressed: (){
                                item.amount ++;
                                CartCubit.get(context).changedAmountOfProduct();
                                CartCubit.get(context).calculateTotalPrice();

                              }, icon: const Icon(Icons.add),),
                              // child: ,
                            ],
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            item.amount = 1;
                            CartCubit.get(context).removeItemFromCart(item);
                            CartCubit.get(context).calculateTotalPrice();

                          },
                          icon: const Icon(
                            Icons.delete,
                            color: mainGreenColor,
                            size: 35.0,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

