import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

String baseUrl = 'https://disease.sh/v3/covid-19/';
String apiKey = '';

class API {
  static Dio dio = Dio();
  // Get Token if required
  Options? getToken(bool useToken) {
    if (useToken) {
      debugPrint('ACCESS TOKEN : $apiKey');
      return Options(headers: {
        "Authorization": apiKey,
      });
    }
    return null;
  }

  // Get Request
  Future<Response> get(
    String endPoint, {
    bool useToken = false,
    Map<String, dynamic>? queryParameters,
  }) async {
    debugPrint('GET API : $baseUrl$endPoint');
    Response response = await dio.get(
      '$baseUrl$endPoint',
      queryParameters: queryParameters,
      options: getToken(useToken),
    );
    return response;
  }
}
