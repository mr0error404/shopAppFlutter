import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/models/categories_models.dart';
import 'package:shopapp/models/change_favorites_model.dart';
import 'package:shopapp/models/favorites_model.dart';
import 'package:shopapp/models/homeModel.dart';
import 'package:shopapp/models/loginModel.dart';
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
        // favorites.addAll({
        //   52: true,
        //   86:true,
        // });
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

  ChangeFavoritesModel? changeFavoritesModel;

  void changeFavorites(int productID ){
    favorites[productID] = !favorites[productID]!;
    emit(ShopChangeFavoritesState());
    DioHelper.postData(
        url: FAVORITES,
        data: {"product_id": productID},
      token: token,
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      print(value.data);
      if(!changeFavoritesModel!.status!){
        favorites[productID] = !favorites[productID]!;
      }else{
        getFavorites();
      }
      emit(ShopSuccessChangeFavoritesState(changeFavoritesModel!));
    }).catchError((onError){
      favorites[productID] = !favorites[productID]!;
      print(onError.toString());
      emit(ShopErrorChangeFavoritesState());
    });
  }


  FavoritesModel? favoritesModel; // ----> error
  void getFavorites() {
    emit(
      ShopLoadingGetFavoritesState(),
    );
    DioHelper.getData(
        url: FAVORITES,
      token: token,
    ).then(
          (value) {
        emit(
          ShopSuccessGetFavoritesState(),
        );
        // categoriesModel = categoriesModel?.fromJson( json: value.data);
        // categoriesModel = categoriesModel.fromJson(json : value.data);  /// error 999
        favoritesModel = FavoritesModel.fromJson(value.data)!;  /// error 999

        print(
          favoritesModel.toString(),
        );
      },
    ).catchError((error) {
      print(
        error.toString(),
      );
      emit(
        ShopSuccessGetFavoritesState (),
      );
    });
  }


  LoginModel? userModel; // ----> error
  void getUserData() {
    emit(
      ShopLoadingUserDataState(),
    );
    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then(
          (value) {

        // categoriesModel = categoriesModel?.fromJson( json: value.data);
        // categoriesModel = categoriesModel.fromJson(json : value.data);  /// error 999
        userModel = LoginModel.fromJson(json: value.data)!;  /// error 999

        print(
          userModel!.data!.name!.toString(),
        );
        emit(
          ShopSuccessUserDataState(userModel!),
        );
      },
    ).catchError((error) {
      print(
        error.toString(),
      );
      emit(
        ShopErrorUserDataState (),
      );
    });
  }
}
