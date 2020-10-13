

import 'package:flutter/material.dart';
import 'bloc.dart';


class BlocProvider<T extends Bloc> extends InheritedWidget {
  final T bloc;
  final Widget child;

  // we must wrap the provider over the widgets top hirerchey..
  // in order to do that we have to define the constructor to make it as child
  BlocProvider({@required this.bloc, Key key,@required this.child}) : super(key:key,child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    // TODO: implement updateShouldNotify
    throw UnimplementedError();
  }

  //context will be more clear at this point ... Provider.of(context) is sent from bottomm widget...
  // so this method call raises to the to till it finds the nearest widget of type Provider ..
  // so it gets to the nearest provider and gets bloc values from there .. and not all the providers ...
  // context plays key role in finding the widgets hirarical position in the huge widget tree

  static Bloc of<T extends Bloc>(BuildContext context){
    var bloc = context.dependOnInheritedWidgetOfExactType<BlocProvider<T>>().bloc;
    return bloc;
  }

}

// 1
//class BlocProvider<T extends Bloc> extends StatefulWidget {
//  final Widget child;
//  final T bloc;
//
//  const BlocProvider({Key key, @required this.bloc, @required this.child})
//      : super(key: key);
//
//  // 2
//  static T of<T extends Bloc>(BuildContext context) {
//    final type = _providerType<BlocProvider<T>>();
//    final BlocProvider<T> provider = context.findAncestorRenderObjectOfType();
//    return provider.bloc;
//  }
//
//  // 3
//  static Type _providerType<T>() => T;
//
//  @override
//  State createState() => _BlocProviderState();
//}
//
//class _BlocProviderState extends State<BlocProvider> {
//  // 4
//  @override
//  Widget build(BuildContext context) => widget.child;
//
//  // 5
//  @override
//  void dispose() {
//    widget.bloc.dispose();
//    super.dispose();
//  }
//}


