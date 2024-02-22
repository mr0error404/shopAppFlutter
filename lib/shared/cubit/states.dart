import 'package:shopapp/models/loginModel.dart';

abstract class ShopStates {}

class ShopAppInitialState extends ShopStates {}

class ShopAppLoadingState extends ShopStates {

}

class ShopAppSuccessState extends ShopStates {
  LoginModel? loginModel;
  ShopAppSuccessState(this.loginModel);
}

class ShopAppErrorState extends ShopStates {
  final String error;
  ShopAppErrorState(this.error);
}

class ShopAppChangePasswordVisibilityState extends ShopStates {}
