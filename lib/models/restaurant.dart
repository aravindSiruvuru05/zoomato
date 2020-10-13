

import 'dart:convert';

class Restaurant {
  String id;
  String name;
  String url;
  RestaurantLocation restaurantLocation;
  String timings;
  String average_cost_for_two;
  String currency;
  List<String> highlights;
  String thumb;
  String cuisines;
  int all_reviews_count;
  bool is_delivering_now;
  String phone_numbers;

  List<String> get getCuisins {
    return cuisines.split(",");
  }

  double get stars {
    return this.all_reviews_count / 50;
  }

  Restaurant({
    this.id,
    this.name,
    this.url,
    this.restaurantLocation,
    this.timings,
    this.average_cost_for_two,
    this.currency,
    this.cuisines,
    this.highlights,
    this.thumb,
    this.all_reviews_count,
    this.is_delivering_now,
    this.phone_numbers,
  });

  Restaurant.fromJson(Map<String, dynamic> json)
      : this.id = json['id'],
        this.name = json['name'],
        this.url = json['url'],
        this.restaurantLocation = json['location'] == null
            ? null
            : RestaurantLocation.fromMap(json['location']),
        this.timings = json['timings'],
        this.cuisines = json['cuisines'],
        this.average_cost_for_two = json['average_cost_for_two'].toString(),
        this.currency = json['currency'],
        this.highlights = (json['highlights'] as List<dynamic>).map((e) => e.toString()).toList(),
        this.thumb = json['thumb'],
        this.all_reviews_count = json['all_reviews_count'] as int,
        this.is_delivering_now =
        (json['is_delivering_now'] as int == 0) ? false : true,
        this.phone_numbers = json['phone_numbers'];

  Restaurant.fromJsonOfLocalDB(Map<String, dynamic> json)
      : this.id = json['id'],
        this.name = json['name'],
        this.url = json['url'],
        this.restaurantLocation =RestaurantLocation.fromMap(jsonDecode(json['restaurantLocation'])),
        this.timings = json['timings'],
        this.cuisines = json['cuisines'],
        this.average_cost_for_two = json['average_cost_for_two'],
        this.currency = json['currency'],
//        this.highlights = null,
        this.highlights =List<String>.from(jsonDecode(json['highlights'])),
        this.thumb = json['thumb'],
        this.all_reviews_count = json['all_reviews_count'],
        this.is_delivering_now = json['is_delivering_now'] == 1,
        this.phone_numbers = json['phone_numbers'];

   Map<String,dynamic> toMapForDb(){
    return <String,dynamic>{
      'id': id,
      'name': name,
      'url': url,
      'restaurantLocation': jsonEncode(restaurantLocation.toMap()),
      'timings': timings,
      'average_cost_for_two': average_cost_for_two,
      'currency': currency,
      'cuisines': cuisines,
      'highlights': jsonEncode(highlights),
      'thumb': thumb,
      'all_reviews_count': all_reviews_count,
      'is_delivering_now': is_delivering_now ? 1 : 0,
      'phone_numbers': phone_numbers,
    };
  }
}

class RestaurantLocation {
  String address;
  String locality;
  String city;
  String city_id;
  String latitude;
  String longitude;
  String zipcode;
  String country_id;
  String locality_verbose;



  RestaurantLocation({
    this.address,
    this.locality,
    this.city,
    this.city_id,
    this.latitude,
    this.longitude,
    this.zipcode,
    this.country_id,
    this.locality_verbose,
  });

  Map<String,dynamic> toMap() {
    return <String,dynamic> {
      "address": address,
      "locality": locality,
      "city": city,
      "city_id": city_id,
      "latitude": latitude,
      "longitude": longitude,
      "zipcode": zipcode,
      "country_id": country_id,
      "locality_verbose": locality_verbose,
    };
  }

  RestaurantLocation.fromMap(Map<String, dynamic> json)
      : this.address = json['address'],
        this.locality = json['locality'],
        this.city = json['city'],
        this.city_id = json['city_id'].toString(),
        this.latitude = json['latitude'],
        this.longitude = json['longitude'],
        this.zipcode = json['zipcode'],
        this.country_id = json['country_id'].toString(),
        this.locality_verbose = json['locality_verbose'];
}
