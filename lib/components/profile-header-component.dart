import 'package:flutter/material.dart';
import 'package:ijudi/model/profile.dart';
import 'package:ijudi/util/theme-utils.dart';

class ProfileHeaderComponent extends StatelessWidget {
  final Color profilePicBorder;
  final Profile profile;

  ProfileHeaderComponent(
      {@required this.profile, @required this.profilePicBorder});

  @override
  Widget build(BuildContext context) {

    double deviceWidth = MediaQuery.of(context).size.width;
    double profilePicWidth = deviceWidth >= 360 ? 123 : 108;

    Widget ratings = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(left: 4, right: 4),
            child: Column(
              children: <Widget>[
                Text("${profile.likes}", style: IjudiStyles.RATING),
                Text("Likes", style: IjudiStyles.RATING_LABEL)
              ],
            )),
        Padding(
            padding: EdgeInsets.only(left: 4, right: 4),
            child: Column(
              children: <Widget>[
                Text("${profile.servicesCompleted}", style: IjudiStyles.RATING),
                Text("Served", style: IjudiStyles.RATING_LABEL)
              ],
            )),
        Padding(
            padding: EdgeInsets.only(left: 4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("${profile.badges}", style: IjudiStyles.RATING),
                Image.asset("assets/images/badge.png")
              ],
            )),
      ],
    );

    Widget contacts = Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(padding: EdgeInsets.only(right: 8),
          child: Icon(Icons.phone, color: IjudiColors.backgroud),
        ),
        Text(profile.mobileNumber, style: IjudiStyles.HEADER_TEXT)
      ],
    );

    Widget profilePic = Container(
        width: profilePicWidth,
        height: profilePicWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(61),
          color: Colors.white,
          border: Border.all(
            color: profilePicBorder,
            width: 3,
          ),
          image: DecorationImage(
            image: NetworkImage(profile.imageUrl),
            fit: BoxFit.cover,
          ),
        )
    );

    return Container(
        height: 237,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(profile.name, style: IjudiStyles.HEADER_1),
              Text("${profile.role}", style: IjudiStyles.SUBTITLE_1),
              Padding(padding: EdgeInsets.only(top: 16)),
              Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ratings,
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("Location", style: IjudiStyles.SUBTITLE_1),
                              Container(
                               width: 180,
                               child: Text(profile.address,
                                  style: IjudiStyles.HEADER_TEXT, maxLines: 2,
                                  overflow: TextOverflow.ellipsis)
                              )
                            ]),
                        Padding(padding: EdgeInsets.only(top: 16)),
                        contacts
                      ],
                    ),
                    profilePic
                  ])
            ]));
  }
}
