import 'package:flutter/material.dart';
import 'package:zoomato/bloc/bloc_provider.dart';
import 'package:zoomato/bloc/bookmarks_bloc.dart';
import 'package:zoomato/models/restaurant.dart';
import 'package:zoomato/screens/restaurant_detail_screen.dart';

class RestaurantListTile extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantListTile({Key key, this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BookmarksBloc bookmarksBloc = BlocProvider.of<BookmarksBloc>(context);
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => RestaurantDetailScreen(restaurant: restaurant,)));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5,vertical: 10),
        height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey,
            boxShadow:  [BoxShadow(
              color: Colors.black38,
              blurRadius: 3.0,
            ),],
            image: restaurant.thumb.contains('http')
                ? DecorationImage(image: NetworkImage(restaurant.thumb),fit: BoxFit.cover)
                : null
            ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.black45,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child:  StreamBuilder<List<Restaurant>>(
                    stream: bookmarksBloc.bookmarkStream,
                    builder: (context, snapshot) {
                      final bookmarked = bookmarksBloc.bookmarkedIds.contains(restaurant.id);

                      return IconButton(
                        iconSize: 25,
                        icon: bookmarked ? Icon(Icons.bookmark) : Icon(Icons.bookmark_border),
                        color: Colors.white,
                        onPressed: () {
                          bookmarksBloc.addRemoveBookmark(restaurant);
                        },
                      );
                    }
                  ),
                )
              ],
            ),
            Spacer(),
            Container(
              height: 75,
              padding: EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(restaurant.name,style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(restaurant.cuisines,style: TextStyle(
                    color: Colors.black38,
                  ),),
                  Container(
                    height: 20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: restaurant.stars.ceil(),
                          itemBuilder: (BuildContext context, int index){
                            if(restaurant.stars.floor() == index) {
                              return Icon(Icons.star_half,color: Colors.red,size: 20,);
                            }
                            return Icon(Icons.star,color: Colors.red,size: 20,);
                          },
                        ),
                        Text("${restaurant.currency}${restaurant.average_cost_for_two} for Two")
                      ],
                    ),
                  ),
                ],
              ),
              decoration:  BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(10),bottomLeft: Radius.circular(10),),
              ),
            )
          ],
        )
      ),
    );
  }
}
