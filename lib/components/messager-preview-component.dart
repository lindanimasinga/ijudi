import 'package:flutter/material.dart';
import 'package:ijudi/model/userProfile.dart';
import 'package:ijudi/util/theme-utils.dart';

class MessagerPreviewComponent extends StatefulWidget {
  final UserProfile messenger;

  MessagerPreviewComponent({this.messenger});

  @override
  _MessagerPreviewComponentState createState() =>
      _MessagerPreviewComponentState(messenger);
}

class _MessagerPreviewComponentState extends State<MessagerPreviewComponent> {
  UserProfile messanger;

  _MessagerPreviewComponentState(this.messanger);

  @override
  Widget build(BuildContext context) {

    Widget ratings = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
            padding: EdgeInsets.only(left: 4, right: 4),
            child: Column(
              children: <Widget>[
                Text("${messanger.likes}", style: IjudiStyles.RATING_DARK),
                Text("Likes", style: IjudiStyles.RATING_LABEL_DARK)
              ],
            )),
        Padding(
            padding: EdgeInsets.only(left: 4, right: 4),
            child: Column(
              children: <Widget>[
                Text("${messanger.servicesCompleted}", style: IjudiStyles.RATING_DARK),
                Text("Served", style: IjudiStyles.RATING_LABEL_DARK)
              ],
            )),
        Padding(
            padding: EdgeInsets.only(left: 4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("${messanger.badges}", style: IjudiStyles.RATING_DARK),
                Image.asset("assets/images/badge.png", width: 40,)
              ],
            )),
      
                    ],
                  );

    return Container(
      height: 86,
      padding: EdgeInsets.only(left: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border.all(color: IjudiColors.color5, width: 0.05),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
              width: 73,
              height: 73,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(61),
                color: Colors.white,
                border: Border.all(
                  width: 3,
                  color: IjudiColors.color1
                ),
                image: DecorationImage(
                  image: NetworkImage(messanger.imageUrl),
                  fit: BoxFit.cover,
                ),
              )),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(messanger.name, style: Forms.INPUT_TEXT_STYLE),
                  ratings,
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.check_circle, color: IjudiColors.color1),
                  Container(
                    width: 73,
                    child:Text("Responds in ${messanger.responseTimeMinutes} min",
                      style: IjudiStyles.RATING_LABEL_DARK, textAlign: TextAlign.center,),
                  )                
                ],
              )
        ],
      ),

    );
  }
}
