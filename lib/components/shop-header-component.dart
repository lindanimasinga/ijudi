import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ijudi/components/bread-crumb.dart';
import 'package:ijudi/model/profile.dart';
import 'package:ijudi/model/shop.dart';
import 'package:ijudi/util/theme-utils.dart';
import 'package:intl/intl.dart';

class ShopHeaderComponent extends StatelessWidget {
  final Color profilePicBorder;
  final Shop profile;

  ShopHeaderComponent({required this.profile, required this.profilePicBorder});

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double profilePicWidth = deviceWidth >= 360 ? 163 : 148;

    var profileStatus = Container(
        margin: EdgeInsets.only(right: 16),
        child: BreadCrumb(
            lowerCase: false,
            color: (profile).storeOffline
                ? IjudiColors.color2
                : IjudiColors.color1,
            name: (profile).storeOffline ? "OFFLINE" : "ONLINE"));

    Widget contacts = Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(profile.mobileNumber!, style: IjudiStyles.HEADER_TEXT),
        Padding(
          padding: EdgeInsets.only(left: 8),
          child: Icon(Icons.phone_enabled, color: IjudiColors.backgroud),
        )
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
            width: 4,
          ),
          image: DecorationImage(
            image: NetworkImage(profile.imageUrl!),
            fit: BoxFit.cover,
          ),
        ));

    return Container(
        margin: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
        height: 215,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
            Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(profile.name!, style: IjudiStyles.HEADER_1),
              profileStatus
            ],
          ),
          Text("${describeEnum(profile.role!)}", style: IjudiStyles.SUBTITLE_1),
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
                              margin: EdgeInsets.only(top: 8),
                              width: 180,
                              child: Text(profile.address!,
                                  style: IjudiStyles.HEADER_TEXT,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis))
                        ]),
                    Padding(padding: EdgeInsets.only(top: 8)),
                    contacts,
                    Container(
                        margin: EdgeInsets.only(top: 8),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: profile.businessHours
                                .map((time) => Text(
                                    "${DateFormat('HH:mm').format(time.open)} - ${DateFormat('HH:mm').format(time.close)} ${describeEnum(time.day)}",
                                    style: IjudiStyles.CARD_ICON_BUTTON_WHITE))
                                .toList()))
                  ],
                ),
                profilePic
              ])
        ]));
  }
}
