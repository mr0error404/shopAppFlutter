import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/models/loginModel.dart';
import 'package:shopapp/shared/cubit/states.dart';
import 'package:shopapp/shared/network/endPoint.dart';
import 'package:shopapp/shared/network/remote/dioHelper.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopAppInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);
  LoginModel? loginModel;

  void userLogin({
    required String email,
    required String password,
  }) {
    print("------Start------");
    emit(
      ShopAppLoadingState(),
    );
    DioHelper.postData(
      url: LOGIN,
      data: {
        "email": email,
        "password": password,
      },
    ).then(
      (value) {
        loginModel = LoginModel.fromJson(json: value.data);
        print("------Value------");
        print(loginModel?.data?.name);
        print(loginModel?.data?.id);
        print(loginModel?.data?.token);
        print(loginModel?.message);
        // print(value.data['message']);
        // print(value.data['data']['phone']);
        // print(value.data['data']['token']);
        print(value.toString());
        emit(
          ShopAppSuccessState(loginModel),
        );
      },
    ).catchError((error) {
      print("------Error------");
      print(error.toString());
      emit(
        ShopAppErrorState(
          error.toString(),
        ),
      );
    });
  }

  IconData suffix = Icons.visibility;
  bool isPasswordShow = true;

  void changePasswordVisibility() {
    isPasswordShow = !isPasswordShow;
    suffix = isPasswordShow ? Icons.visibility : Icons.visibility_off;
    emit(ShopAppChangePasswordVisibilityState());
  }
}
