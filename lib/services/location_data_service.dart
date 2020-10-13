import 'dart:convert';

import 'package:http/http.dart';
import 'package:zoomato/models/location.dart';
import 'package:zoomato/models/location_data.dart';
import 'package:zoomato/models/restaurant.dart';
import 'package:zoomato/services/mapping/location_data_mapping.dart';
import 'package:zoomato/services/mapping/location_mapping.dart';
import 'package:zoomato/services/mapping/restaurant_mapping.dart';

import 'base/base_api_service.dart';

class LocationDataService {
  final _apiKey = '3469acd87f80a5a6cb75e937d9de047c';
  final _host = 'developers.zomato.com';
  final _contextRoot = 'api/v2.1';

  final _headers = {
    'Content-type': 'application/json',
    'user-key': '3469acd87f80a5a6cb75e937d9de047c',
  };

  static final LocationDataService _locationDataService =
      LocationDataService._();

  factory LocationDataService() => _locationDataService;
  LocationDataService._();

  BaseAPIService baseApi = BaseAPIService();

  Future<Location> getLocationByCoordinates(double lat, double lon) async {
    final params = {
      'lat': lat.toString(),
      'lon': lon.toString()
    };
    final uri = Uri.https(_host, '$_contextRoot/geocode', params);

    return await baseApi
        .get(uri, headers: _headers)
        .then(
      (response) {
        LocationMapping locationMapping = LocationMapping(response);
        try {
          return locationMapping.isSuccess()
              ? locationMapping.parse(locationMapping.map['location'])
              : null;
        } catch (e) {
          print(e);
          return null;
        }
      },
    );
  }

  Future<List<Restaurant>> fetchRestaurants(Location location, String query) async {
//    String formattedUrl = "https://developers.zomato.com/api/v2.1/search?entity_id=82470&entity_type=subzone";
//    final formattedUrl = Uri.encodeFull("https://developers.zomato.com/api/v2.1/search?entity_id=${location.entity_id}?entity_type=${location.entity_type}");
//    print(formattedUrl);
    final params =   {
    'entity_id': location.entity_id.toString(),
    'entity_type': location.entity_type,
    'q': query,
    'count': '10'
    };
    final uri = Uri.https(_host, '$_contextRoot/search', params);
    Response response = await baseApi.get(uri, headers: _headers);

    RestaurantMapping restaurantMapping = RestaurantMapping(response);


    final restaurants = restaurantMapping.map['restaurants']
        .map<Restaurant>((json) => Restaurant.fromJson(json['restaurant']))
        .toList(growable: false);

    return restaurants;
  }


  Future<List<Location>> getLocationByQuery(String query) async {
    final params =   { 'query': query };
    final uri = Uri.https(_host, '$_contextRoot/locations', params);

    Response response = await baseApi.get(uri, headers: _headers);

    LocationMapping locationMapping = LocationMapping(response);

    final locations =
        locationMapping.map['location_suggestions'];
    final finalLocations =
        locations?.map<Location>((e) => Location.fromJson(e))?.toList();

    return locationMapping.isSuccess() ? finalLocations : null;
  return null;
  }
}



//Future<LocationData> getLocationDatafromEntity(
//    int entity_id, String entity_type) async {
//  print(entity_id);
//
//  Response response = await baseApi.get(
//      "$_search?entity_id=$entity_id&entity_type=$entity_type",
//      headers: _headers);
//  LocationDataMapping locationDataMapping = LocationDataMapping(response);
//
//  return locationDataMapping.isSuccess()
//      ? locationDataMapping.parse(locationDataMapping.map)
//      : null;
//}
