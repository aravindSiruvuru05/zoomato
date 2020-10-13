import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:zoomato/bloc/bloc_provider.dart';
import 'package:zoomato/bloc/cart_bloc.dart';

class CartScreen extends StatelessWidget {
  CartBloc cartBloc;
  @override
  Widget build(BuildContext context) {
    cartBloc = BlocProvider.of<CartBloc>(context);
    return SafeArea(
        child: Scaffold(
        body: Container(
          child: Column(
            children: [
              cartBloc.restaurantName == null
                  ? Text("No Items in cart")
                  : Text(cartBloc.restaurantName),
              Expanded(
                child: StreamBuilder<Map<String,int>>(
                    stream: cartBloc.cartStream,
                    initialData: cartBloc.cartItems,
                    builder: (context, snapshot) {
                      Map<String, int> cartMap = snapshot.data;
                      List<String> names = cartMap.keys.toList();
                      return ListView.builder(
                        itemCount: cartMap.keys.length,
                          itemBuilder: (BuildContext context, int index){
                          return ListTile(
                            title: Text(names[index]),
                            trailing: Container(
                              child: Text(cartMap[names[index]].toString()),
                            ),
                          );
                          }
                      );
                    }
                ),
              ),
            ],
          ),
        ),
    ),
      );
  }
}
