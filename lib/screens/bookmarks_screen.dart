

import 'package:flutter/material.dart';
import 'package:zoomato/bloc/bloc_provider.dart';
import 'package:zoomato/bloc/bookmarks_bloc.dart';
import 'package:zoomato/models/restaurant.dart';
import 'package:zoomato/widgets/restaurant_list_tile.dart';

class BookmarksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BookmarksBloc bloc = BlocProvider.of<BookmarksBloc>(context);
    print(bloc);
    return Scaffold(
      appBar: AppBar(
        title: Text("Bookarks"),
      ),
      body: StreamBuilder<List<Restaurant>>(
        stream: bloc.bookmarkStream,
        initialData: bloc.bookmarks.isEmpty ? null : bloc.bookmarks,
        builder:  (context, snapshot) {
          final restaurants = snapshot.data;
          if(restaurants == null || restaurants.isEmpty){
            return Center(child: Text("No bookmarks"),);
          }
          return ListView.builder(
              itemCount: restaurants.length,
              itemBuilder: (BuildContext context, int index){
                return RestaurantListTile(restaurant: restaurants[index]);
              }
          );
        },
      ),
    );
  }
}