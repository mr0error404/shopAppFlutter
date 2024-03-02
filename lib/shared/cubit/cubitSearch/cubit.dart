import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/models/search_model.dart';
import 'package:shopapp/shared/components/constanys.dart';
import 'package:shopapp/shared/cubit/cubitSearch/state.dart';
import 'package:shopapp/shared/network/endPoint.dart';
import 'package:shopapp/shared/network/remote/dioHelper.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? model;

  void search(String txt) {
    emit(SearchLoadingState());
    DioHelper.postData(
      url: SEARCH,
      token: token,
      data: {"text": txt},
    ).then(
      (value) {
        model = SearchModel.fromJson(value.data);
        emit(SearchSuccessState());
      },
    ).catchError((onError) {
      print(
        onError.toString(),
      );
      emit(SearchErrorState());
    });
  }
}
