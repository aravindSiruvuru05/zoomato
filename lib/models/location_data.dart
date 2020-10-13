import 'package:zoomato/models/restaurant.dart';

import 'location.dart';

class LocationData {
  List<String> nearby_res;
  List<String> top_cuisines;
  Location location;
  int num_restaurant;
  List<Restaurant> best_rated_restaurant;

  LocationData({
    this.nearby_res,
    this.top_cuisines,
    this.location,
    this.num_restaurant,
    this.best_rated_restaurant,
  });

  LocationData.fromJson(Map<String, dynamic> json)
      : this.nearby_res = (json['nearby_res'] as List<dynamic>)
            .map((e) => e.toString())
            .toList(),
        this.top_cuisines = (json['top_cuisines'] as List<dynamic>)
            .map((e) => e.toString())
            .toList(),
        this.location = Location.fromJson(json['location']),
        this.num_restaurant = json['num_restaurant'],
        this.best_rated_restaurant =
            (json['best_rated_restaurant'] as List<dynamic>)
                .map((e) => Restaurant.fromJson(e))
                .toList();
}
