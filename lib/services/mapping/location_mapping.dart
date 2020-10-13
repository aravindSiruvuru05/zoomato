import 'package:http/http.dart';
import 'package:zoomato/models/location.dart';
import 'package:zoomato/services/base/mapping.dart';

class LocationMapping extends Mapping<Location> {
  LocationMapping(Response response) : super(response);

  @override
  Location parse(Map<String, dynamic> data) {
    return Location.fromJson(data);
  }
}
