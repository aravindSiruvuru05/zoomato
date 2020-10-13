
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:zoomato/bloc/bloc_provider.dart';
import 'package:zoomato/bloc/location_bloc.dart';
import 'package:zoomato/models/restaurant.dart';

class RestaurantDetailScreen extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantDetailScreen({Key key, this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250,
            backgroundColor: Colors.red,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(restaurant.name),
              background: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(restaurant.thumb),
                      fit: BoxFit.cover,colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                margin: EdgeInsets.only(top: 15,right: 15,left: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("30 mins", style: TextStyle(color: Colors.blue,fontSize: 12,fontWeight: FontWeight.bold),),
                        Text("no live tracking", style: TextStyle(color: Colors.grey,fontSize: 12),)
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.grey[200],
                      ),
                      child: IconButton(
                        icon: Icon(Icons.share),
                        onPressed: (){
                          Share.share(restaurant.url);
                        },
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 10),
                child: ListTile(
                  title: Text("Delivering to this address"),
                  subtitle: Text(restaurant.restaurantLocation.locality_verbose),
                  trailing: Icon(Icons.keyboard_arrow_down),
                  leading: Padding(padding: EdgeInsets.only(top:5),
                      child: Icon(Icons.my_location,color: Colors.deepPurple,size: 30,)),
                )
              ),
            ]),
          ),
          SliverFixedExtentList(
            itemExtent: 60,  // I'm forcing item heights
            delegate: SliverChildBuilderDelegate(
                  (context, index) => Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    margin: EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow:  [BoxShadow(
                        color: Colors.black38,
                        blurRadius: 3.0,
                      ),],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          restaurant.getCuisins[index],
                          style: TextStyle(fontSize: 15.0),
                        ),
                        Container(
                          color: Colors.red[100],
                          child: Row(
                            children: [
                              AddItemToCart(text: "-",onTap: (){print("decrease");},),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 3),
                                child: Text("Add",style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),),
                              ),
                              AddItemToCart(text: "+",onTap: (){print("increase");},),
                            ],
                          ),
                        ),
                      ],
                    ),
//                      ListTile(
//                    subtitle: Text(
//                      "100 rs"
//                    ),
//                title: Container(
//                  child: Text(
//                    restaurant.getCuisins[index],
//                    style: TextStyle(fontSize: 15.0),
//                  ),
//                ),
//                    trailing: SizedBox(
//                      height: 15,
//                      width: 30,
//                      child: Row(
//                        children: [
//                          FlatButton(
//                            child: Text("-",style: TextStyle(fontSize: 10),),
//                          ),
//                          Text("Add",style: TextStyle(fontSize: 10),),
//                          FlatButton(
//                            child: Text("+",style: TextStyle(fontSize: 10),),
//                          )
//                        ],
//                      ),
//                    ),
              ),
              childCount: restaurant.getCuisins.length,
            ),
          ),

        ],
      ),
    );
  }
}

class AddItemToCart extends StatelessWidget {
  final text;
  final onTap;

  const AddItemToCart({
    Key key,@required this.text,@required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: Text(text,style: TextStyle(fontSize: 20),),
        ),
      ),
    );
  }
}
