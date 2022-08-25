import 'package:flutter/material.dart';
import 'package:la_vie/core/shared/constants.dart';
import 'package:la_vie/core/widgets/default_button.dart';
import 'package:la_vie/models/products_model.dart';

import '../../../../core/utils/bloc/cart_bloc/cart_cubit.dart';

class ProductItem extends StatelessWidget {
  final ProductData productData;

  const ProductItem({Key? key, required this.productData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      height: 300,
      child: Stack(
        children: [
          Column(
            children: [
              const SizedBox(height: 90.0),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 100,
                    height: 180,
                    child: Image.network(
                  "$baseUrl${productData.imageUrl}",
                  fit: BoxFit.contain,
                )),
                // const SizedBox(
                //   height: 15.0,
                // ),
                Expanded(
                  child: Text(
                    "${productData.name}",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18.0, overflow: TextOverflow.ellipsis),
                  ),
                ),
                // Spacer(),

                Text(
                  "${productData.price} EGP",
                  style:
                      const TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: DefaultButton(
                    childWidget: const Text(
                      "Add To Cart",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      CartCubit.get(context).addItemToCart(productData);
                    },
                    height: 35.0,
                    borderRadius: 10.0,
                  ),
                ),
              ],
            ),
          ),
          // Image.network(baseUrl + itemData.imageUrl!, fit: BoxFit.cover,),
        ],
      ),
    );
  }
}
