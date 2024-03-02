import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/models/favorites_model.dart';
import 'package:shopapp/modules/products/productsScreen.dart';
import 'package:shopapp/shared/components/components.dart';
import 'package:shopapp/shared/cubit/cubitShop/cubit.dart';
import 'package:shopapp/shared/cubit/cubitShop/states.dart';
import 'package:shopapp/shared/style/colors.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubitApp, ShopStatesApp>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is! ShopLoadingGetFavoritesState,
          // condition: true,
          builder: (context) => ListView.separated(
            physics: AlwaysScrollableScrollPhysics(),
            itemBuilder: (context, index) => buildListProduct(
                ShopCubitApp.get(context)
                    .favoritesModel!
                    .data!
                    .data![index]
                    .product!,
                context),
            separatorBuilder: (context, index) => myDivider(),
            // itemCount: ShopCubitApp.get(context).categoriesModel!.data!.data!.length,
            itemCount:
                ShopCubitApp.get(context).favoritesModel!.data!.data!.length!,
          ),
          fallback: (context) => Center(
            child: CircleAvatar(),
          ),
        );
      },
    );
  }

  // Widget buildFavItem(FavoritesData model ,context) => Padding(

  
}
