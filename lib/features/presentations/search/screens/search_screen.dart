import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie/core/utils/bloc/home_bloc/home_cubit.dart';
import 'package:la_vie/core/utils/bloc/home_bloc/home_states.dart';
import 'package:la_vie/features/presentations/home/screens/home_screen.dart';
import 'package:la_vie/features/presentations/search/widgets/recrent_search_item.dart';
import 'package:la_vie/models/products_model.dart';

import '../../../../core/widgets/default_text_form_field_v2.dart';
import '../../home/widgets/product_item.dart';

class SearchScreen extends StatelessWidget {
  final List<ProductData> listToSearchFrom;

  const SearchScreen({Key? key, required this.listToSearchFrom})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: DefaultFormFieldV2(
              hintText: "Search",
              prefixIcon: Icons.search,
              textInputType: TextInputType.text,
              onFieldSubmitted: (value) {
                HomeCubit.get(context).searchResult = [];
                for (var item in listToSearchFrom) {

                  if (item.name == value) {
                    HomeCubit.get(context).searchResult.add(item);
                  }

                }
                print(HomeCubit.get(context).searchResult);
              },
            ),
          ),
          Expanded(
              child: ListView.separated(
                  itemBuilder: (context, index) => ProductItem(productData: HomeCubit.get(context).searchResult[index]),
                  separatorBuilder: (context, index) => SizedBox(height: 10,),
                  itemCount: HomeCubit.get(context).searchResult.length
              ),
          ),

        ],
      ),
    );
  }
}
