import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:zoomato/bloc/bloc_provider.dart';
import 'package:zoomato/bloc/location_bloc.dart';
import 'package:zoomato/bloc/location_query_bloc.dart';
import 'package:zoomato/models/location.dart';
import 'package:zoomato/services/location_data_service.dart';
import 'package:zoomato/utils/dialog_popup.dart';
import 'package:zoomato/utils/geo_location.dart';
import 'package:zoomato/widgets/prefix_icon_textfield.dart';



class BuildBottomSheet extends StatelessWidget {
  LocationQueryBloc locationQueryBloc = LocationQueryBloc();
  LocationBloc locationBloc;
  @override
  Widget build(BuildContext context) {
    locationBloc = BlocProvider.of<LocationBloc>(context);
    return Container(
      padding: EdgeInsets.all(10),
      height: MediaQuery.of(context).size.height * 0.8,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Select Location",
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.close,
                  color: Colors.black54,
                  size: 30,
                ),
              ),
            ],
          ),
          PrefixIconTextField(
            text: "Search for Location",
            icon: Icons.search,
            onChange: locationQueryBloc.submitQuery,
          ),

          StreamBuilder<List<Location>>(
              stream: locationQueryBloc.locationsStream,
              builder: (context, snapshot) {
                final results = snapshot.data;

                if (results == null || results.isEmpty) {
                  return Column(
                    children: [
                      InkWell(
                        onTap: () {
                          locationFromCoordinates(context);
                        },
                        child: Container(
                          padding: EdgeInsets.all(12),
                          child: Row(
                            children: [
                              Icon(
                                Icons.my_location,
                                color: Colors.red[300],
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Use Current Location",
                                style: TextStyle(
                                    color: Colors.red, fontSize: 20),
                              ),
                              Spacer(),
                            ],
                          ),
                        ),
                      ),
                      Divider(
                        height: 5,
                        thickness: 1,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Recent Locations",
                        style: TextStyle(fontSize: 20, color: Colors.black),
                        textAlign: TextAlign.left,
                      ),
//                      StreamBuilder<Location>(
//                            stream: locationBloc.locationStream,
//                            builder: (context, snapshot) {
//                              final recentLocations = snapshot.data;
//                              if(recentLocations == null){
//                                print(locationBloc.recentLocationsList);
//                                return Center(
//                                    child: Text("no recent locations checked out yet ...")
//                                );
//                              }
//                              return Text(recentLocations.title);
////                                ListView.builder(
////                                shrinkWrap: true,
////                                  itemCount: recentLocations.length,
////                                  itemBuilder: (context, index){
////                                    return Text(recentLocations[index].title);
////                                  }
////                              );
//                            }
//                        )
                    ],
                  );
                }
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: results.length,
                  itemBuilder: (BuildContext context, int index) {
                    print(index);
                    return ListTile(
                      title: Text(results[index].title),
                      onTap: () {
                        //  print(index.toString());
                        locationBloc.selectLocation(results[index]);
                        Navigator.pop(context);
                      },
                    );
                  },
                );
              }
          )
        ],
      ),
    );
  }

  void locationFromCoordinates(BuildContext context) async {
    bool granted = await GeoLocation.checkLocationPermission();
    if (!granted) {
      Navigator.pop(context);
      DialogPopUp.showlocationPermissionPopup(context);
      return;
    }
    Position position =
    await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    Location location = await LocationDataService().getLocationByCoordinates(
        position.latitude, position.longitude);
    LocationBloc locationBloc = BlocProvider.of<LocationBloc>(context);
    locationBloc.selectLocation(location);
    Navigator.pop(context);
  }

}