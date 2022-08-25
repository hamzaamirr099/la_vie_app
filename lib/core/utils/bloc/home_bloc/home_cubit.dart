import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie/core/utils/bloc/home_bloc/home_states.dart';
import 'package:la_vie/models/products_model.dart';
import '../../../shared/components.dart';
import '../../network/remote/dio_helper.dart';


class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(InitState());

  static HomeCubit get(context) => BlocProvider.of(context);

  ProductsModel? productsModel;

  List<ProductData> plants = [];
  List<ProductData> tools = [];
  List<ProductData> seeds = [];

  List<ProductData> listToView = []; //filter that we want to view

  List<String> recentSearches = [];

  List<ProductData> searchResult = [];


  void showSearchResult()
  {
    emit(SearchState());
  }
  Future<void> getAllProducts({required String token}) async {
    try {
      Response value = await DioHelper.getData(
        url: '/api/v1/products',
        token: token,
      );
      // showToastMessage(message: "${value.data['message']}");
      productsModel = ProductsModel.fromJson(value.data);

      listToView = productsModel!.data!;
      filterAllProducts();
      emit(SuccessFetchProductsState());
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
      emit(ErrorFetchProductsState());
    }
  }

  void changeCategoryView(int categoryIndex)
  {
    if(productsModel != null)
      {
        if(categoryIndex == 0)
        {
          listToView = productsModel!.data!;
        }
        else if(categoryIndex == 1)
        {
          listToView = plants;

        }
        else if(categoryIndex == 2)
        {
          listToView = seeds;

        }
        else if(categoryIndex == 3)
        {
          listToView = tools;
        }

        emit(CategoryChangedState());
      }

  }
  void filterAllProducts()
  {
    plants = [];
    tools = [];
    seeds = [];

    for (ProductData element in productsModel!.data!)
    {
      if(element.type == 'PLANT')
        {
          plants.add(element);
        }
      else if(element.type == 'SEED')
        {
          seeds.add(element);
        }
      else if(element.type == 'TOOL')
        {
          tools.add(element);
        }

    }

  }



}
