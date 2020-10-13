import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:zoomato/bloc/bloc_provider.dart';
import 'package:zoomato/bloc/location_bloc.dart';
import 'package:zoomato/bloc/restaurant_bloc.dart';
import 'package:zoomato/models/enums/highlights.dart';
import 'package:zoomato/models/location.dart';
import 'package:zoomato/models/restaurant.dart';
import 'package:zoomato/utils/dialog_popup.dart';
import 'package:zoomato/utils/geo_location.dart';
import 'package:zoomato/widgets/restaurant_list.dart';
import 'package:zoomato/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {

  @override
  Widget build(BuildContext context) {
    LocationBloc locationBloc = BlocProvider.of<LocationBloc>(context);
    return SafeArea(
      child: Scaffold(
          body: Container(
            padding: EdgeInsets.all(8),
            child: StreamBuilder<Location>(
                stream: locationBloc.locationStream,
                builder: (context, snapshot) {
                  Location location = snapshot.data;
                  return Column(
                    children: [
                          LocationHeader(
                            location: location == null ?  "Select Location" : location.title,
                            subLocality: "",
                            onPressed: (){
                              DialogPopUp.showLocationChooserBottomSheet(context);
                            },),
                      SizedBox(height: 10,),
                      Expanded(child: buildRestaurantResuts(locationBloc.selectedLocation))
                    ],
                  );
                }
            ),
          ),
      ),
    );
  }


  Widget buildRestaurantResuts(Location location){
    if(location == null){
      return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network('https://img.icons8.com/cotton/2x/worldwide-location.png'),
              Text("Please Select location to continue...",
                style: TextStyle(
                color: Colors.black38,
                fontStyle: FontStyle.italic,
              ),)
            ],
          )
      );
    }
    return RestaurantList(location: location);
  }


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.inactive:
        print('appLifeCycleState inactive');
        break;
      case AppLifecycleState.resumed:
        print('appLifeCycleState resumed');
        break;
      case AppLifecycleState.paused:
        print('appLifeCycleState paused');
        break;
    }
  }
}








//void getLocation() async {
//  bool granted = await GeoLocation.checkLocationPermission();
//  if (!granted) {
//    DialogPopUp.showlocationPermissionPopup(context);
//  } else {
//    DialogPopUp.showLocationChooserBottomSheet(context);
//  }
//}
// expanded should be always decendent of column or row or flex..
//if you want to use listview in column it shuold be defnetly wraped in a expanded or sized box
// if you are listning to a stream only once ... and you made it as brodcast ... it will not work ..final
// if you need to listen more than one time only we shuld go with brodcast