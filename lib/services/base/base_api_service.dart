import 'dart:convert';

import 'package:http/http.dart' as http;

class BaseAPIService {
  int connectionTimeout = 30;

  static final BaseAPIService _baseApi = BaseAPIService._internal();

  factory BaseAPIService() => _baseApi;

  BaseAPIService._internal();

  Future<http.Response> get(Uri resourceURI,
      {Map<String, String> headers}) async {
    return await http
        .get(
          resourceURI,
          headers: headers,
        )
        .timeout(Duration(seconds: connectionTimeout))
        .then((response) {
      return response;
    });
  }

  Future<http.Response> post(String resourceURI,
      {Map<String, String> headers, body, Encoding encoding}) async {
    return await http
        .post(resourceURI, headers: headers, body: body, encoding: encoding)
        .timeout(Duration(seconds: connectionTimeout))
        .then((response) {
      return response;
    });
  }
}

//bool isSuccess(http.Response response) {
//  switch (response.statusCode) {
//    case HTTP_STATUS_SUCCESS:
//      print("success");
//      return true;
//    case HTTP_STATUS_CREATED:
//      return true;
//    case HTTP_STATUS_BAD_REQUEST:
//      onError("Bad Request", response);
//      return false;
//    case HTTP_STATUS_UNAUTHORIZED:
//      onError("Unauthorized", response);
//      return false;
//    case HTTP_STATUS_FORBIDDEN:
//      onError("Forbidden", response);
//      return false;
//    case HTTP_STATUS_NOT_FOUND:
//      onError("Not Found", response);
//      return false;
//    case HTTP_STATUS_INTERNAL_SERVER_ERROR:
//      onError("Internal Server Error", response);
//      return false;
//    default:
//      return false;
//  }
//}
//
//onError(String prefix, http.Response response) {
//  print("$prefix : ${response.request.url} API call ended with error code ${response.statusCode}");
//}
//const HTTP_STATUS_SUCCESS = 200;
//const HTTP_STATUS_CREATED = 201;
//const HTTP_STATUS_BAD_REQUEST = 400;
//const HTTP_STATUS_UNAUTHORIZED = 401;
//const HTTP_STATUS_FORBIDDEN = 403;
//const HTTP_STATUS_NOT_FOUND = 404;
//const HTTP_STATUS_INTERNAL_SERVER_ERROR = 500;
//
