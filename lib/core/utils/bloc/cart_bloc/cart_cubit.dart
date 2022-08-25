import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie/core/utils/bloc/cart_bloc/cart_states.dart';
import '../../../../core/shared/components.dart';
import '../../../../core/shared/constants.dart';
import '../../../../core/utils/network/local/cach_helper.dart';
import '../../../../core/utils/network/remote/dio_helper.dart';
import '../../../../models/products_model.dart';

class CartCubit extends Cubit<CartStates> {
  CartCubit() : super(InitState());

  static CartCubit get(context) => BlocProvider.of(context);

  List<ProductData> allCartItems = [];

  List<String> cartItemsIds = [];

  int totalPrice = 0;


  void calculateTotalPrice()
  {
    totalPrice = 0;
    for (ProductData element in allCartItems) {
      totalPrice += (element.price! * element.amount);
    }
    emit(ChangeTotalPriceState());
  }

  void getCartItemsFromShared()
  {
    cartItemsIds = []; // to save in shared pref
    allCartItems = []; // to show the actual products in cart screen
    if(CacheHelper.getCartItems(key: 'cartItems') != null)
    {
      cartItemsIds = CacheHelper.getCartItems(key: 'cartItems')!;
    }
    else
    {
      cartItemsIds = [];
    }

    for (String element in cartItemsIds) {
      getOneCartItem(token: userToken, productId: element);

    }
  }


  void addItemToCart(ProductData item)
  {
    if(allCartItems.contains(item))
    {
      showToastMessage(message: "Already in cart");
    }
    else
    {
      // add item itself to array of ProductData type
      allCartItems.add(item);

      //save items ids in shared pref to restore them when opening the app again
      cartItemsIds.add(item.productId as String);
      CacheHelper.saveData(key: 'cartItems', value: cartItemsIds);
      showToastMessage(message: "added to cart");
      emit(ItemAddedToCart());
    }

  }

  void removeItemFromCart(ProductData item)
  {
    // remove the item itself from cart
    allCartItems.remove(item);

    // remove the item id to update the shared pref
    cartItemsIds.remove(item.productId);

    print(cartItemsIds.toString());

    CacheHelper.saveData(key: 'cartItems', value: cartItemsIds);
    emit(ItemRemovedFromCart());
  }


  void getOneCartItem({required String token, required String productId}) async {
    try {
      Response value = await DioHelper.getData(
        url: '/api/v1/products/$productId',
        token: token,
      );
      print(value.data);
      allCartItems.add(ProductData.fromJson(value.data['data']));
      showToastMessage(message: "${value.data['message']}");
      emit(SuccessFetchOneCartItemState());
    } on DioError catch (e) {
      if(e.response == null)
      {
        showToastMessage(message: "Check you connection", toastColor: Colors.red);
      }
      else
      {
        debugPrint(e.response!.data);
        showToastMessage(message: "${e.response!.data['message']}", toastColor: Colors.red);
      }
      emit(ErrorFetchOneCartItemState());
    }
  }

  void changedAmountOfProduct()
  {
    emit(AmountOfProductChanged());
  }

}
