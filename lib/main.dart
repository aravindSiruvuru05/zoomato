import 'package:flutter/material.dart';
import 'package:zoomato/bloc/bloc_provider.dart';
import 'package:zoomato/bloc/bookmarks_bloc.dart';
import 'package:zoomato/bloc/cart_bloc.dart';
import 'package:zoomato/bloc/location_bloc.dart';
import 'package:zoomato/screens/home_screen.dart';
import 'package:zoomato/screens/main_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<LocationBloc>(
      bloc: LocationBloc(),
      child: BlocProvider<BookmarksBloc>(
        bloc: BookmarksBloc(),
        child: BlocProvider<CartBloc>(
          bloc: CartBloc(),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primaryColor: Colors.red,
            ),
            home: MainScreen(),
          ),
        ),
      )
    );
  }
}
