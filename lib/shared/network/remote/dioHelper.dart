import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;
  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
        headers: {
          "Content-Type": "application/json",
        },
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String lang = "en",
    String? token,
  }) async {
    dio!.options.headers = {
      "Content-Type": "application/json",
      "lang": lang,
      "Authorization": token,
    };
    // dio!.options = BaseOptions(
    //   headers: {
    //     "lang": lang,
    //     "Authorization": token,
    //   },
    // );
    return dio!.get(
      url,
      queryParameters: query,
    );
  }

  //   static Future<Response?> postData({
  //   required String url,
  //   Map<String, dynamic>? query,
  //   required Map<String, dynamic> data,
  // }) async {
  //   if (dio != null) {
  //     return await dio!.post(
  //       url,
  //       queryParameters: query,
  //       data: data,
  //     );
  //   } else {
  //     throw Exception('Dio instance is null. Make sure to call DioHelper.init() before using Dio.');
  //   }
  // }

  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String lang = "en",
    String? token,
  }) async {
    // dio!.options = BaseOptions(
    //   headers: {
    //     "lang": lang,
    //     "Authorization": token,
    //   },
    // );
    dio!.options.headers = {
      "Content-Type": "application/json",
      "lang": lang,
      "Authorization": token,
    };
    return await dio!.post(
      url,
      queryParameters: query,
      data: data,
    );
  }

  static Future<Response> putData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String lang = "en",
    String? token,
  }) async {
    dio!.options.headers = {
      "Content-Type": "application/json",
      "lang": lang,
      "Authorization": token,
    };
    return await dio!.put(
      url,
      queryParameters: query,
      data: data,
    );
  }
}
