import 'package:geolocator/geolocator.dart';

class GeoLocation {
  static Future<bool> checkLocationPermission() async {
//    await requestPermission();
    LocationPermission permission = await checkPermission();

    bool isLocationServiceEnable = await isLocationServiceEnabled();

    if (!isLocationServiceEnable ||
        permission == LocationPermission.deniedForever ||
        permission == LocationPermission.denied) {
      return false;
    }
    return true;
  }
}
