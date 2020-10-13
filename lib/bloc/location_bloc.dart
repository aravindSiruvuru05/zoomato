import 'dart:async';
import '../models/location.dart';
import 'bloc.dart';

class LocationBloc implements Bloc {
  Location _location;
  Location get selectedLocation => _location;

  List<Location> recentLocationsList = [];

  LocationBloc(){
    _recentLocationsController.sink.add(recentLocationsList);
  }

  final _recentLocationsController = StreamController<List<Location>>.broadcast();


  // 1
  final _locationController = StreamController<Location>.broadcast();

  // 2
  Stream<Location> get locationStream => _locationController.stream;
  Stream<List<Location>> get recentLocationsStream => _recentLocationsController.stream;

  // 3
  void selectLocation(Location location) {
    _location = location;
    _locationController.sink.add(location);
    if(recentLocationsList.length > 3){
      recentLocationsList.removeAt(0);
    }
    recentLocationsList.add(location);
    _recentLocationsController.sink.add(recentLocationsList);
  }

  // 4
  @override
  void dispose() {
    _recentLocationsController.close();
    _locationController.close();
  }
}
