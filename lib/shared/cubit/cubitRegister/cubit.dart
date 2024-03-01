import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/models/loginModel.dart';
import 'package:shopapp/shared/cubit/cubitLogin/states.dart';
import 'package:shopapp/shared/cubit/cubitRegister/states.dart';
import 'package:shopapp/shared/network/endPoint.dart';
import 'package:shopapp/shared/network/remote/dioHelper.dart';

class ShopRgisterCubit extends Cubit<ShopRegisterStates> {
  ShopRgisterCubit() : super(ShopAppRegisterInitialState());

  static ShopRgisterCubit get(context) => BlocProvider.of(context);
  LoginModel? loginModel;

  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) {
    print("------Start--- register--1-");
    emit(
      ShopAppRegisterLoadingState(),
    );
    print("------Start--- register--2-");
    DioHelper.postData(
      url: REGISTER,
      data: {
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
      },
    ).then(
          (value) {
            print("------Start--- register-3--");
            print("---------- REGISTER ---------------------");
        loginModel = LoginModel.fromJson(json: value.data);
        print("------Value------");
        // print(loginModel?.data?.name);
        // print(loginModel?.data?.id);
        // print(loginModel?.data?.token);
        // print(loginModel?.message);
        // print(value.data['message']);
        // print(value.data['data']['phone']);
        // print(value.data['data']['token']);
        print(value.toString());
        emit(
          ShopAppRegisterSuccessState(loginModel),
        );
      },
    ).catchError((error) {
      print("------Error------");
      print("------Start--- register---error");
      print("error ---------> " +error.toString());
      emit(
        ShopAppRegisterErrorState(
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
    emit(ShopAppChangePasswordRegVisibilityState());
  }
}
