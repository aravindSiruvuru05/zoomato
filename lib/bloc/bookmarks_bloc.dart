import 'dart:async';
import 'package:zoomato/bloc/bloc.dart';
import 'package:zoomato/models/restaurant.dart';
import 'package:zoomato/services/local_db/localdb.dart';

class BookmarksBloc extends Bloc {
  List<Restaurant> _bookmarks = [];

  final _bookmarkController = StreamController<List<Restaurant>>.broadcast();

  List<String> get bookmarkedIds {
    return _bookmarks.map((e) => e.id).toList();
  }

  Stream<List<Restaurant>> get bookmarkStream => _bookmarkController.stream;
  List<Restaurant> get bookmarks => _bookmarks;

  BookmarksBloc(){
   _init();
   _bookmarkController.stream.listen((event) {print(event);});
  }

  _init() async{
    final result =await LocalDB.localDb.getAllBookmarks();
    if(result == null ) return;
    _bookmarks = result;
    _bookmarkController.sink.add(_bookmarks);
  }

  void addRemoveBookmark(Restaurant restaurant) async{
    final ids = await LocalDB.localDb.getIds();
    if(ids.contains(restaurant.id)) {
      await LocalDB.localDb.deleteBookmark(restaurant.id);
      _bookmarks = _bookmarks.where((element) => element.id != restaurant.id).toList();
      _bookmarkController.sink.add(_bookmarks);
    }
    else {
      await LocalDB.localDb.addBookmark(restaurant);
      _bookmarks.add(restaurant);
      _bookmarkController.sink.add(_bookmarks);
    }
  }

  @override
  void dispose() {
    _bookmarkController.close();
    // TODO: implement dispose
  }


}