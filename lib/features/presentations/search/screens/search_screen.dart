import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie/core/utils/bloc/home_bloc/home_cubit.dart';
import 'package:la_vie/core/utils/bloc/home_bloc/home_states.dart';
import 'package:la_vie/features/presentations/home/screens/home_screen.dart';
import 'package:la_vie/models/products_model.dart';
import '../../../../core/widgets/default_text_form_field_v2.dart';

class SearchScreen extends StatelessWidget {
  final List<ProductData> listToSearchFrom;

  const SearchScreen({Key? key, required this.listToSearchFrom})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = HomeCubit.get(context);
    homeCubit.searchResult = [];
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            DefaultFormFieldV2(
              hintText: "Search",
              prefixIcon: Icons.search,
              textInputType: TextInputType.text,
              onChangedFunction: (value) {
                homeCubit.searchResult = [];
                for (var item in listToSearchFrom) {

                  if (value!.toLowerCase().matchAsPrefix(item.name!.toLowerCase()) != null) {
                    homeCubit.searchResult.add(item);
                  }

                }
                homeCubit.showSearchResult();
              },
            ),
            BlocConsumer<HomeCubit, HomeStates>(
              listener: (context, state) {},
              builder: (context, state) {
                return HomeScreen().homeBuilder(context, HomeCubit.get(context).searchResult);
              },
            ),

          ],
        ),
      ),
    );
  }
}
