import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/models/categories_models.dart';
import 'package:shopapp/models/homeModel.dart';
import 'package:shopapp/modules/categories/categoriesScreen.dart';
import 'package:shopapp/modules/favorites/favoriteScreen.dart';
import 'package:shopapp/modules/products/productsScreen.dart';
import 'package:shopapp/modules/settings/settingsScreen.dart';
import 'package:shopapp/shared/components/constanys.dart';
import 'package:shopapp/shared/cubit/cubitShop/states.dart';
import 'package:shopapp/shared/network/endPoint.dart';
import 'package:shopapp/shared/network/remote/dioHelper.dart';

class ShopCubitApp extends Cubit<ShopStatesApp> {
  ShopCubitApp() : super(ShopInitialSttes());

  // static ShopCubitApp get(context) => BlocProvider.of(context);
  static ShopCubitApp get(context) => BlocProvider.of<ShopCubitApp>(context);

  int currentIndex = 0;

  List<Widget> bottomScreens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  void changeBottom(index) {
    currentIndex = index;
    emit(
      ShopChangeBottomNavState(),
    );
  }

  HomeModel? homeModel; // ----> error
  Map<int , bool > favorites = {};
  void getHomeData() {
    emit(
      ShopLoadingHomeDataState(),
    );
    DioHelper.getData(url: HOME).then(
      (value) {
        emit(
          ShopSuccessHomeDataState(),
        );
        print("fav -----> "+favorites.toString());
        print("-------------- Hello 1 --------------");
        homeModel = HomeModel.fromJson(json: value.data);
        print("-------------- Hello 2 --------------");
        print(
          homeModel?.data?.banners[0].image.toString(),
        );

        print("-------------- Hello 3 --------------");
        print(
          homeModel.toString(),
        );

        // if (homeModel != null && homeModel!.data != null) {
          // print("RUN __________---------____--");
          homeModel!.data!.products.forEach((element) {
            // print("Product id: ${element.id}, inFavorites: ${element.inFavorites}");
            favorites.addAll({
              element.id!: element.inFavorites!,
            });
          });
        // }
        favorites.addAll({
          52: true,
          86:true,
        });
        print("fav -----> "+favorites.toString());
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

  CategoriesModel? categoriesModel; // ----> error
  void getCategoriesData() {
    emit(
      ShopLoadingHomeDataState(),
    );
    DioHelper.getData(url: GET_CATEGORIIES).then(
          (value) {
        emit(
          ShopSuccessCategoriesDataState(),
        );
        // categoriesModel = categoriesModel?.fromJson( json: value.data);
        // categoriesModel = categoriesModel.fromJson(json : value.data);  /// error 999
        categoriesModel = CategoriesModel.fromJson(value.data)!;  /// error 999

        print(
          categoriesModel.toString(),
        );
      },
    ).catchError((error) {
      print(
        error.toString(),
      );
      emit(
        ShopErrorCategoriesDataState(),
      );
    });
  }

  void changeFavorites(int productID ){
    DioHelper.postData(
        url: FAVORITES,
        data: {"product_id": productID},
      token: token,
    ).then((value) {
      emit(ShopSuccessChangeFavoritesState());
    }).catchError((onError){
      print(onError.toString());
      emit(ShopErrorChangeFavoritesState());
    });
  }
}
