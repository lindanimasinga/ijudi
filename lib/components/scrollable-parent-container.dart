import 'package:flutter/material.dart';
import 'package:ijudi/components/menu-component.dart';
import 'package:ijudi/model/profile.dart';

class ScrollableParent extends StatelessWidget {
  final menu = MenuComponent();
  final Widget child;
  final String title;
  final Color? appBarColor;
  final bool hasDrawer;
  final appBarPinned;

  ProfileRoles? role;

  ScrollableParent(
      {required this.title,
      this.appBarColor,
      this.appBarPinned = false,
      required this.hasDrawer,
      required this.child});

  @override
  Widget build(BuildContext context) {
    final Brightness brightnessValue =
        MediaQuery.of(context).platformBrightness;
    bool isLight = brightnessValue == Brightness.light;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 2,
            color: appBarColor,
          ),
          CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                floating: true,
                pinned: appBarPinned,
                iconTheme: IconThemeData(
                    color: !isLight || appBarColor is Color
                        ? Colors.white
                        : Colors.black),
                backgroundColor: appBarColor is Color ? appBarColor : null,
                title: Text(title,
                    style: TextStyle(
                        color: !isLight || appBarColor is Color
                            ? Colors.white
                            : Colors.black)),
              ),
              SliverList(
                  delegate: SliverChildListDelegate([
                Container(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: child)
              ]))
            ],
          )
        ],
      ),
      drawer: hasDrawer ? Drawer(child: MenuComponent()) : null,
    );
  }
}
