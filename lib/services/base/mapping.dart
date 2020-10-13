import 'dart:convert';

import 'package:http/http.dart';
import 'api_exception_handling.dart';

abstract class Mapping<T> {
  Response response;
  Map<String, dynamic> map;

  Mapping(this.response) {
    this.map = decodeJson(response);
    if (map == null) {
      print(
          "Failed to parse reponse mapping ended with status:${response.statusCode}");
    }
  }
  Map<String, dynamic> decodeJson(Response response) {
    try {
      return json.decode(response.body);
    } catch (e) {
      return null;
    }
  }

  bool isSuccess() {
    switch (response.statusCode) {
      case HTTP_STATUS_SUCCESS:
        return true;
      case HTTP_STATUS_CREATED:
        return true;
      case HTTP_STATUS_DELETED:
        return true;
      case HTTP_STATUS_BAD_REQUEST:
        throw BadRequestException(
            response.statusCode, response.body.toString());
      case HTTP_STATUS_UNAUTHORIZED:
      case HTTP_STATUS_FORBIDDEN:
        throw UnauthorisedException(
            response.statusCode, response.body.toString());
      case HTTP_STATUS_NOT_FOUND:
        throw NotFoundException(response.statusCode, response.body.toString());
      case HTTP_STATUS_INTERNAL_SERVER_ERROR:
      default:
        throw FetchDataException(response.statusCode, response.body.toString());
    }
  }

  T parse(Map<String, dynamic> data);

  List<T> toList(List<dynamic> items) {
    List<T> list = [];
    for (dynamic item in items) {
      list.add(parse(item));
    }
    return list;
  }
}

const HTTP_STATUS_SUCCESS = 200;
const HTTP_STATUS_CREATED = 201;
const HTTP_STATUS_DELETED = 204;
const HTTP_STATUS_BAD_REQUEST = 400;
const HTTP_STATUS_UNAUTHORIZED = 401;
const HTTP_STATUS_FORBIDDEN = 403;
const HTTP_STATUS_NOT_FOUND = 404;
const HTTP_STATUS_INTERNAL_SERVER_ERROR = 500;
