import 'package:flutter/material.dart';
import 'package:zoomato/screens/bookmarks_screen.dart';

class LocationHeader extends StatelessWidget {
  final String location;
  final String subLocality;
  final Function onPressed;

  const LocationHeader(
      {Key key,
        @required this.location,
        @required this.onPressed,
        this.subLocality})
      : super(key: key);



  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: onPressed,
      child: Row(
        children: [
        Icon(
        Icons.location_on,
        size: 35,
        color: Colors.black87,
      ),
      Expanded(
        flex: 1,
        child: Text("$location $subLocality",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,decoration: TextDecoration.underline)),
      ),
          IconButton(
            icon: Icon(Icons.collections_bookmark,color: Colors.red,),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> BookmarksScreen()));
            },
          )
        ],
    ),
    );
  }
}
