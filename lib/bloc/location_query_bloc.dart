
import 'dart:async';

import 'package:geolocator/geolocator.dart';

import '../models/location.dart';
import '../services/location_data_service.dart';
import 'bloc.dart';

class LocationQueryBloc implements Bloc {


  final _locationsController = StreamController<List<Location>>.broadcast();

  LocationDataService _locationDataService = LocationDataService();
  Stream<List<Location>> get locationsStream => _locationsController.stream;

  void submitQuery(String query) async {
    if(query.length == 0){
      _locationsController.sink.add(null);
      return;
    }

    final results = await _locationDataService.getLocationByQuery(query);
    _locationsController.sink.add(results);
  }
  @override
  void dispose() {
    _locationsController.close();
  }
}
