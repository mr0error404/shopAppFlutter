import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/models/homeModel.dart';
import 'package:shopapp/modules/categories/categoriesScreen.dart';
import 'package:shopapp/modules/favorites/favoriteScreen.dart';
import 'package:shopapp/modules/products/productsScreen.dart';
import 'package:shopapp/modules/settings/settingsScreen.dart';
import 'package:shopapp/shared/cubit/cubitShop/states.dart';
import 'package:shopapp/shared/network/endPoint.dart';
import 'package:shopapp/shared/network/remote/dioHelper.dart';

class ShopCubitApp extends Cubit<ShopStatesApp> {
  ShopCubitApp() : super(ShopInitialSttes());

  static ShopCubitApp get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  late HomeModel homeModel;

  void changeBottom(index) {
    currentIndex = index;
    emit(
      ShopChangeBottomNavState(),
    );
  }

  void getHomeData() {
    emit(
      ShopLoadingHomeDataState(),
    );
    DioHelper.getData(url: HOME).then(
      (value) {
        emit(
          ShopSuccessHomeDataState(),
        );
        print("-------------- Hello 1 --------------");
        homeModel = HomeModel.fromJson(json: value.data);
        print("-------------- Hello 2 --------------");
        print(
          homeModel.data?.banners[0].image.toString(),
        );
        print("-------------- Hello 3 --------------");
        print(
          homeModel.toString(),
        );
        print("-------------- Hello 4 --------------");
      },
    ).catchError((error) {
      print(
        error.toString(),
      );
      emit(
        ShopErrorHomeDataState(),
      );
    });
  }
}
