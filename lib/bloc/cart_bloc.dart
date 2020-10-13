
import 'dart:async';

import 'package:zoomato/bloc/bloc.dart';

class CartBloc extends Bloc {

  String restaurantId;

  Map<String,int> _cartItems = {};

  Map<String,int> get cartItems => _cartItems;

  final _cartItemsStreamController = StreamController<Map<String,int>>.broadcast();
  Stream<Map<String,int>> get cartStream => _cartItemsStreamController.stream;

  modifyCartItems(String item, String rId,bool increment){
    if(restaurantId == null) {
      restaurantId = rId;
      finalCartItems(item,increment);
    }
    else if(restaurantId != rId) {
      restaurantId = rId;
      _cartItems = {};
      finalCartItems(item,increment);
    }
    else {
      finalCartItems(item, increment);
    }
  }

  finalCartItems(String item,bool increment){
    if(increment) {
      _cartItems.containsKey(item) ? _cartItems[item] += 1 : _cartItems[item] = 1 ;
    }else {
      _cartItems[item] = _cartItems[item] == 0 ? 0 : _cartItems[item]--;
    }
    print(cartItems);
    _cartItemsStreamController.sink.add(_cartItems);
  }

  @override
  void dispose() {
    _cartItemsStreamController.close();
    // TODO: implement dispose
  }

}