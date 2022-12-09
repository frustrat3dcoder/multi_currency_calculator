import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:mobx_calculator/app/utils/api.dart';

import 'interceptor/interceptor.dart';

class ApiProvider {
  late final Dio dio;
  late Options options;
  var response;

  ApiProvider() {
    initInterceptor();
  }

  void initInterceptor() {
    dio = Dio();
    dio.interceptors.clear();
    dio.interceptors.add(CustomInterceptor());
  }

  Future<Response> executeGetRequest(
    String url,
  ) async {
    try {
      options = Options(
        headers: {
          "apiKey": "T83cYM31hEIv8RBY3hHWZ0U9wdEAFv3N",
          'content-type': 'application/json',
          'Access-Control-Allow-Origin': 'true'
        },
        validateStatus: (status) => true,
        receiveDataWhenStatusError: true,
        responseType: ResponseType.json,
      );

      await dio.get(
        url,
        options: options,
      ).then((value) async {
        response = value;
      });
    } on DioError catch (error) {
      onReceivedError(error);
    }

    return response;
  }

  onReceivedError(DioError dioError) {
    if (dioError.type == DioErrorType.response) {
      switch (dioError.response!.statusCode) {
        case 404:
          throw Exception("404");
        case 401:
          throw Exception("401 UnAuthorized");
        case 403:
          throw Exception("Forbidden Error Hello");
        case 500:
          throw Exception('500 - Internal Server Error.');
        case 501:
          throw Exception('501 - Not Implemented Server Error.');
        case 502:
          throw Exception('502 - Bad Gateway Server Error.');
        default:
          throw ('${dioError.response!.statusCode} - Something went wrong while trying to connect with the server');
      }
    } else if (dioError.type == DioErrorType.other) {
      log("Error is ${dioError.response!.statusCode}");
      throw Exception('No Internet');
    }
  }
}
