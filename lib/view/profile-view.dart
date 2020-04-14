import 'package:flutter/material.dart';
import 'package:ijudi/util/theme-utils.dart';

class ProfileView extends StatefulWidget {

  static const ROUTE_NAME = "profile";

  @override
  _ProfileViewState createState() => _ProfileViewState();
}


class _ProfileViewState extends State<ProfileView> {

  @override
  Widget build(BuildContext context) {
    return JudiTheme.buildFromParent(
      title: "Profile",
      child: Stack(
        children: <Widget>[
          Headers.getHeader(context),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Phumlani Dube", style: IjudiStyles.HEADER_1,),
                        Text("Messager", style: IjudiStyles.SUBTITLE_1,),
                         Text("Location", style: IjudiStyles.SUBTITLE_1,)
                      ],
                    )
                  ]
                ),
                Cards.shop(child: Container()),
                Cards.shop(child: Container()),
                Cards.shop(child: Container())
              ],
            )
          )
        ],
    ));
  }
}