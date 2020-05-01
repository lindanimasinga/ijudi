import 'package:flutter/material.dart';
import 'package:ijudi/components/menu-component.dart';

class ScrollableParent extends StatelessWidget {
  
  final Widget child;
  final String title;
  final Color appBarColor;
  final bool hasDrawer;

  ScrollableParent({
      @required this.title,
      this.appBarColor,
      @required this.hasDrawer,
      @required this.child});
  
  @override
  Widget build(BuildContext context) {
    final Brightness brightnessValue = MediaQuery.of(context).platformBrightness;
    bool isLight = brightnessValue == Brightness.light;
    return Scaffold(
        body: CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                    iconTheme: IconThemeData(color: !isLight || appBarColor is Color ? Colors.white : Colors.black),
                    backgroundColor: appBarColor is Color  ? appBarColor : null,
                    title: Text(title, style: TextStyle(
                              color: !isLight || appBarColor is Color ? Colors.white : Colors.black
                            )),
                    
                  ),
                  SliverList(delegate: SliverChildListDelegate([
                      child
                    ]
                  ))
                ],
            ),
          drawer: hasDrawer ?Drawer(child: MenuComponent()) : null
    ); 
  }
}