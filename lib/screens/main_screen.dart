import 'package:flutter/material.dart';
import 'package:zoomato/bloc/bloc_provider.dart';
import 'package:zoomato/bloc/cart_bloc.dart';
import 'package:zoomato/screens/cart_screen.dart';
import 'package:zoomato/screens/home_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final List<Widget> _children = [HomeScreen(),CartScreen(),HomeScreen()];

  @override
  Widget build(BuildContext context) {
    CartBloc cartBloc = BlocProvider.of<CartBloc>(context);
    return Scaffold(
      body: _children[_currentIndex], // new
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped, // new
        currentIndex: _currentIndex, // new
        items: [
          new BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          new BottomNavigationBarItem(
            activeIcon:  Icon(Icons.shopping_cart),
            icon: new Stack(
              overflow: Overflow.visible,
                children: <Widget>[
                  new Icon(Icons.shopping_cart),
                  new Positioned(
                    right: -5,
                    top: -5,
                    child: new Container(
                      padding: EdgeInsets.all(1),
                      decoration: new BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      constraints: BoxConstraints(
                        minWidth: 17,
                        minHeight: 17,
                      ),
                      child: StreamBuilder<Map<String,int>>(
                          stream: cartBloc.cartStream,
                          initialData: cartBloc.cartItems,
                          builder: (context, snapshot) {
                            Map<String, int> cartMap = snapshot.data;
                            final count =  cartMap.keys.toList().length.toString();
                            return  new Text(
                              count,
                              style: new TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            );
                          }
                      ),
                    ),
                  )
                ]
            ),
            title: Text('Cart'),
          ),
          new BottomNavigationBarItem(
            activeIcon: Icon(Icons.person),
              icon:  Icon(Icons.person_outline),
              title: Text('Profile')
          )
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
