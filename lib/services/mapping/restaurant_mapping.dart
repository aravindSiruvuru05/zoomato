import 'package:http/http.dart';
import 'package:zoomato/models/restaurant.dart';
import 'package:zoomato/services/base/mapping.dart';

class RestaurantMapping extends Mapping<Restaurant> {
  RestaurantMapping(Response response) : super(response);

  @override
  Restaurant parse(Map<String, dynamic> data) {
    return Restaurant.fromJson(data);
  }
}
