import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/shared/cubit/states.dart';
import 'package:shopapp/shared/network/endPoint.dart';
import 'package:shopapp/shared/network/remote/dioHelper.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopAppInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

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
        print("------Value------");
        print(value.toString());
        emit(
          ShopAppSuccessState(),
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
}
