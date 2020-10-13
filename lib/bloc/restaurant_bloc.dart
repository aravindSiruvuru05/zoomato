///*
// * Copyright (c) 2019 Razeware LLC
// *
// * Permission is hereby granted, free of charge, to any person obtaining a copy
// * of this software and associated documentation files (the "Software"), to deal
// * in the Software without restriction, including without limitation the rights
// * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// * copies of the Software, and to permit persons to whom the Software is
// * furnished to do so, subject to the following conditions:
// *
// * The above copyright notice and this permission notice shall be included in
// * all copies or substantial portions of the Software.
// *
// * Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
// * distribute, sublicense, create a derivative work, and/or sell copies of the
// * Software in any work that is designed, intended, or marketed for pedagogical or
// * instructional purposes related to programming, coding, application development,
// * or information technology.  Permission for such use, copying, modification,
// * merger, publication, distribution, sublicensing, creation of derivative works,
// * or sale is expressly withheld.
// *
// * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// * THE SOFTWARE.
// */
//
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:zoomato/models/enums/highlights.dart';
import 'package:zoomato/models/location.dart';
import 'package:zoomato/models/restaurant.dart';
import 'package:zoomato/services/location_data_service.dart';

import 'bloc.dart';

class RestaurantBloc implements Bloc {
  final Location location;
  List<Restaurant> _restaurantResults = [];
  Map<Highlights,bool> _currentFilters = {};

  LocationDataService _locationDataService = LocationDataService();

  final _restaurantController = StreamController<List<Restaurant>>();
  final _filtersController = StreamController<Map<Highlights,bool>>();

  Stream<List<Restaurant>> get stream => _restaurantController.stream;
  Stream<Map<Highlights,bool>> get filtersStream => _filtersController.stream;

  RestaurantBloc({this.location}){
    final filterMaps = Highlights.values.map((e) => MapEntry(e, false));
    _currentFilters.addEntries(filterMaps);
    _filtersController.sink.add(_currentFilters);
    submitQuery("");
  }

  void modifyFilter(Highlights highlights){
    _currentFilters[highlights] = !_currentFilters[highlights];
    _filtersController.sink.add(_currentFilters);
    Map<Highlights,bool> duplicate = {};
   _currentFilters.forEach((key, value) {
     if(value){
       duplicate.putIfAbsent(key, () => true);
     }
   });

    filterRestaurants(duplicate.keys.toList());
  }

  void filterRestaurants(List<Highlights> filters){
    if(filters.isEmpty) _restaurantController.sink.add(_restaurantResults);
    List<String> filerValues = filters.map((highlight) { return describeEnum(highlight); }).toList();
    final filtered  = _restaurantResults.where((restaurant)  {
       return filerValues.every((element) => restaurant.highlights.contains(element));
     }).toList();
     _restaurantController.sink.add(filtered);
  }

  void submitQuery(String query) async {
    final results = await _locationDataService.fetchRestaurants(location, query);
    _restaurantResults = results;
    _restaurantController.sink.add(_restaurantResults);
  }

  @override
  void dispose() {
    _restaurantController.close();
    _filtersController.close();
  }
}
