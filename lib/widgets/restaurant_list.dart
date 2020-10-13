import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:zoomato/bloc/bloc_provider.dart';
import 'package:zoomato/bloc/restaurant_bloc.dart';
import 'package:zoomato/models/enums/highlights.dart';
import 'package:zoomato/models/restaurant.dart';
import 'package:zoomato/widgets/prefix_icon_textfield.dart';
import 'package:zoomato/widgets/restaurant_list_tile.dart';

class RestaurantList extends StatelessWidget {
  final location;

  const RestaurantList({Key key, this.location}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RestaurantBloc restaurantBloc = RestaurantBloc(location: location);
    return Column(
      children: [
        PrefixIconTextField(
          text: "Search for Resturents, Cusins ..",
          icon: Icons.search,
          onChange: restaurantBloc.submitQuery,
        ),
        SizedBox(height: 10,),
        Container(
          height: 50,
          child: Row(
            children: [
              Row(
                children: [
                  Text("Filters",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,fontSize: 17,color: Colors.red
                    ),
                  ),
                  Icon(Icons.subject),
                  SizedBox(width: 20,),
                ],
              ),
              Expanded(
                child: StreamBuilder<Map<Highlights,bool>>(
                    stream: restaurantBloc.filtersStream,
                    builder: (context, snapshot) {
                      final filtersMap = snapshot.data;
                      if(filtersMap == null || filtersMap.isEmpty){
                        return Text("Loading Filters..");
                      }
                      final filterName = filtersMap.keys.toList();
                      return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: Highlights.values.length,
                          itemBuilder: (BuildContext context, int index){
                            return GestureDetector(
                                onTap: (){
                                  restaurantBloc.modifyFilter(filterName[index]);
                                },
                                child: Container(
                                    margin: EdgeInsets.only(right: 15,top: 10,bottom: 10),
                                    padding: EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                      border: filtersMap[filterName[index]] ? Border.all(
                                        color: Colors.red,
                                        width: 1,
                                      ) : null ,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(describeEnum(filterName[index]),
                                          style: TextStyle(fontSize: 17),
                                        ),
                                        filtersMap[filterName[index]] ? Icon(Icons.close,color: Colors.red,) : SizedBox.shrink(),
                                      ],
                                    )
                                )
                            );
                          }
                      );
                    }
                ),
              ),
            ],

          ),

        ),

        Expanded(
          child: StreamBuilder<List<Restaurant>>(
            stream: restaurantBloc.stream,
            builder:  (context, snapshot) {
              final restaurants = snapshot.data;
              if(restaurants == null){
                return Center(child: Text("Enter a resturant name"),);
              }
              if(restaurants.isEmpty){
                return Center(child: Text("no results"),);
              }
              return ListView.builder(
                  itemCount: restaurants.length,
                  itemBuilder: (BuildContext context, int index){
                    return RestaurantListTile(restaurant: restaurants[index]);
                  }
              );
            },
          ),
        ),
      ],
    );
  }
}
