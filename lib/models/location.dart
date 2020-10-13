class Location {
  String entity_type;
  int entity_id;
  String title;
  double latitude;
  double longitude;
  int city_id;
  String city_name;
  int country_id;
  String country_name;

  Location({
    this.entity_id,
    this.entity_type,
    this.title,
    this.longitude,
    this.latitude,
    this.city_id,
    this.city_name,
    this.country_id,
    this.country_name,
  });

  Location.fromJson(Map<String, dynamic> json)
      : entity_type = json['entity_type'].toString(),
        entity_id = json['entity_id'] as int,
        title = json['title'].toString(),
        longitude = double.parse(json['longitude']
            .toString()), //if gets double convert to string and parse if gets string direct double parse  ...
        latitude = double.parse(json['latitude'].toString()),
        city_id = json['city_id'] as int,
        city_name = json['city_name'].toString(),
        country_id = json['country_id'] as int,
        country_name = json['country_name'].toString();
}
