
import 'dart:async';

import 'package:zoomato/bloc/bloc.dart';

class CartBloc extends Bloc {

  String restaurantId;

  Map<String,int> _cartItems = {};

  Map<String,int> get cartItems => _cartItems;

  final _cartItemsStreamController = StreamController<Map<String,int>>();
  Stream<Map<String,int>> get cartStream => _cartItemsStreamController.stream;

  modifyCartItems(String item, String id){
    if(restaurantId == id) {
      _cartItems.containsKey(item) ? _cartItems[item] += 1 : _cartItems[item] = 0 ;

    }
  }

  @override
  void dispose() {
    _cartItemsStreamController.close();
    // TODO: implement dispose
  }

}