import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ijudi/components/bread-crumb.dart';
import 'package:ijudi/model/profile.dart';
import 'package:ijudi/model/shop.dart';
import 'package:ijudi/util/theme-utils.dart';

class ProfileHeaderComponent extends StatelessWidget {
  final Color profilePicBorder;
  final Profile? profile;

  ProfileHeaderComponent(
      {required this.profile, required this.profilePicBorder});

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double profilePicWidth = deviceWidth >= 360 ? 143 : 128;

    var profileStatus = profile is Shop
        ? Container(
            margin: EdgeInsets.only(right: 16),
            child: BreadCrumb(
                lowerCase: false,
                color: (profile as Shop).storeOffline!
                    ? IjudiColors.color2
                    : IjudiColors.color1,
                name: (profile as Shop).storeOffline! ? "OFFLINE" : "ONLINE"))
        : Container();

    Widget contacts = Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 8),
          child: Icon(Icons.phone_android, color: IjudiColors.backgroud),
        ),
        Text(profile!.mobileNumber!, style: IjudiStyles.HEADER_2_WHITE)
      ],
    );

    Widget profilePic = Container(
        width: profilePicWidth,
        height: profilePicWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(81),
          color: Colors.white,
          border: Border.all(
            color: profilePicBorder,
            width: 3,
          ),
          image: DecorationImage(
            image: NetworkImage(profile!.imageUrl!),
            fit: BoxFit.cover,
          ),
        ));

    return Container(
        height: 207,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(profile!.name!, style: IjudiStyles.HEADER_1),
                  profileStatus
                ],
              ),
              Text("${describeEnum(profile!.role!)}",
                  style: IjudiStyles.SUBTITLE_1),
              Padding(padding: EdgeInsets.only(top: 0)),
              Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                  margin: EdgeInsets.only(top: 16),
                                  width: 180,
                                  child: Text(profile!.address!,
                                      style: IjudiStyles.HEADER_2_WHITE,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis))
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
