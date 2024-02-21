abstract class ShopStates {}

class ShopAppInitialState extends ShopStates {}

class ShopAppLoadingState extends ShopStates {}

class ShopAppSuccessState extends ShopStates {}

class ShopAppErrorState extends ShopStates {
  final String error;
  ShopAppErrorState(this.error);
}
