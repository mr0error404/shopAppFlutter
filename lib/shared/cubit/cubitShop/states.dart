import 'package:shopapp/models/change_favorites_model.dart';
import 'package:shopapp/models/loginModel.dart';

abstract class ShopStatesApp {}

class ShopInitialSttes extends ShopStatesApp {}

class ShopChangeBottomNavState extends ShopStatesApp {}

class ShopLoadingHomeDataState extends ShopStatesApp {}

class ShopSuccessHomeDataState extends ShopStatesApp {}

class ShopErrorHomeDataState extends ShopStatesApp {}

class ShopSuccessCategoriesDataState extends ShopStatesApp {}

class ShopErrorCategoriesDataState extends ShopStatesApp {}

class ShopChangeFavoritesState extends ShopStatesApp {}

class ShopSuccessChangeFavoritesState extends ShopStatesApp {
  final ChangeFavoritesModel model ;
  ShopSuccessChangeFavoritesState(this.model);
}

class ShopErrorChangeFavoritesState extends ShopStatesApp {}

class ShopLoadingGetFavoritesState extends ShopStatesApp {}

class ShopSuccessGetFavoritesState extends ShopStatesApp {}

class ShopErrorGetFavoritesState extends ShopStatesApp {}

class ShopLoadingUserDataState extends ShopStatesApp {}

class ShopSuccessUserDataState extends ShopStatesApp {
  LoginModel  loginModel;
  ShopSuccessUserDataState(this.loginModel);
}

class ShopErrorUserDataState extends ShopStatesApp {}
