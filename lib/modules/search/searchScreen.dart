import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/models/favorites_model.dart';
import 'package:shopapp/shared/components/components.dart';
import 'package:shopapp/shared/cubit/cubitSearch/cubit.dart';
import 'package:shopapp/shared/cubit/cubitSearch/state.dart';
import 'package:shopapp/shared/cubit/cubitShop/cubit.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var searchController = TextEditingController();
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    defaultFormField(
                      textEditingController: searchController,
                      prefix: Icons.search,
                      type: TextInputType.none,
                      validation: (value) {
                        if (value!.isEmpty) {
                          return "Enter text to search";
                        }
                        return null;
                      },
                      onSubmitted: (String text) {
                        SearchCubit.get(context).search(text);
                      },
                      label: "Search",
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    LinearProgressIndicator(),
                    if (state is SearchSuccessState)
                      Expanded(
                        child: ListView.separated(
                          physics: AlwaysScrollableScrollPhysics(),
                          itemBuilder: (context, index) => buildListProduct(
                            SearchCubit.get(context).model!.data!.data![index],
                            context,
                            isOldPrice: false,
                          ),
                          separatorBuilder: (context, index) => myDivider(),
                          // itemCount: ShopCubitApp.get(context).categoriesModel!.data!.data!.length,
                          itemCount: SearchCubit.get(context)
                              .model!
                              .data!
                              .data!
                              .length!,
                        ),
                      ),
                    SizedBox(
                      height: 20.0,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
