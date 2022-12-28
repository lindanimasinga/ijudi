import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ijudi/model/profile.dart';
import 'package:ijudi/model/userProfile.dart';
import 'package:ijudi/util/theme-utils.dart';

class MessagerPreviewComponent extends StatefulWidget {
  final UserProfile? messenger;
  Function? selected = () => false;

  MessagerPreviewComponent({this.messenger, this.selected});

  @override
  _MessagerPreviewComponentState createState() =>
      _MessagerPreviewComponentState(messenger, selected);
}

class _MessagerPreviewComponentState extends State<MessagerPreviewComponent> {
  UserProfile? messanger;
  Function? selected;

  _MessagerPreviewComponentState(this.messanger, this.selected);

  @override
  Widget build(BuildContext context) {
    Widget ratings = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          children: <Widget>[
            Text("10", style: IjudiStyles.RATING_DARK),
            Text("Likes", style: IjudiStyles.RATING_LABEL_DARK)
          ],
        ),
        Padding(padding: EdgeInsets.only(right: 8)),
        Column(
          children: <Widget>[
            Text("50", style: IjudiStyles.RATING_DARK),
            Text("Served", style: IjudiStyles.RATING_LABEL_DARK)
          ],
        ),
        Padding(padding: EdgeInsets.only(right: 8)),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("3", style: IjudiStyles.RATING_DARK),
            Image.asset(
              "assets/images/badge.png",
            )
          ],
        ),
        Padding(padding: EdgeInsets.only(right: 8)),
        Text(
          describeEnum(messanger!.availabilityStatus!),
          style: messanger!.availabilityStatus! ==
                  ProfileAvailabilityStatus.OFFLINE
              ? IjudiStyles.DIALOG_IMPORTANT_TEXT
              : IjudiStyles.CARD_DISCR_ITAL,
        )
      ],
    );

    return Container(
      height: 90,
      padding: EdgeInsets.only(left: 0),
      decoration: BoxDecoration(
        color: selected != null && selected!()
            ? IjudiColors.color5
            : Theme.of(context).cardColor,
        border: Border.all(color: IjudiColors.color5, width: 0.05),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
              width: 73,
              height: 73,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(61),
                color: Colors.white,
                border: Border.all(width: 1, color: IjudiColors.color1),
                image: DecorationImage(
                  image: NetworkImage(messanger!.imageUrl!),
                  fit: BoxFit.cover,
                ),
              )),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Padding(padding: EdgeInsets.only(top: 8)),
              Text(messanger!.name!, style: Forms.INPUT_TEXT_STYLE),
              ratings,
            ],
          )
        ],
      ),
    );
  }
}
