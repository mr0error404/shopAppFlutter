import 'package:bloc/bloc.dart';
import 'package:shopapp/shared/cubit/states.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(NewsInitialState());
}
