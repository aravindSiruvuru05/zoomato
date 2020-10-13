import 'package:http/http.dart';
import 'package:zoomato/models/location_data.dart';
import 'package:zoomato/services/base/mapping.dart';

class LocationDataMapping extends Mapping<LocationData> {
  LocationDataMapping(Response response) : super(response);

  @override
  LocationData parse(Map<String, dynamic> data) {
    return LocationData.fromJson(data);
  }
}
