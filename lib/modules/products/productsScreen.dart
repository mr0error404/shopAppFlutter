import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/shared/cubit/cubitShop/cubit.dart';
import 'package:shopapp/shared/cubit/cubitShop/states.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubitApp, ShopStatesApp>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ShopCubitApp.get(context).homeModel?.data != null,
          // condition: true,
          builder: (context) => productsBuilder(),
          fallback: (context) => Center(
            child: CircleAvatar(),
          ),
        );
      },
    );
  }

  Widget productsBuilder() {
    return Column(
      children: [],
    );
  }
}
