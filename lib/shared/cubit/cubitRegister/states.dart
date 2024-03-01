import 'package:shopapp/models/loginModel.dart';

abstract class ShopRegisterStates {}

class ShopAppRegisterInitialState extends ShopRegisterStates {}

class ShopAppRegisterLoadingState extends ShopRegisterStates {

}

class ShopAppRegisterSuccessState extends ShopRegisterStates {
  LoginModel? loginModel;
  ShopAppRegisterSuccessState(this.loginModel);
}

class ShopAppRegisterErrorState extends ShopRegisterStates {
  final String error;
  ShopAppRegisterErrorState(this.error);
}

class ShopAppChangePasswordRegVisibilityState extends ShopRegisterStates {}
