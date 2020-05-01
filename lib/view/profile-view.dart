import 'package:flutter/material.dart';
import 'package:ijudi/api/api-service.dart';
import 'package:ijudi/components/profile-header-component.dart';
import 'package:ijudi/components/scrollable-parent-container.dart';
import 'package:ijudi/components/shop-component.dart';
import 'package:ijudi/model/profile.dart';
import 'package:ijudi/util/theme-utils.dart';
import 'package:ijudi/view/personal-and-bank.dart';

class ProfileView extends StatefulWidget {
  static const ROUTE_NAME = "profile";

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  Profile userProfile;

  @override
  void initState() {
    userProfile = ApiService.findUserById("idfrom memry");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScrollableParent(
        hasDrawer: true,
        appBarColor: IjudiColors.color1,
        title: "Profile",
        child: Stack(
          children: <Widget>[
            Headers.getHeader(context),
            Container(
                //  margin: EdgeInsets.only(left: 16, right: 16),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.only(left: 16, right: 16),
                        child: ProfileHeaderComponent(
                            profile: userProfile,
                            profilePicBorder: IjudiColors.color3)),
                    buildProfileCard(
                        action: () => Navigator.pushNamed(
                            context, PersonalAndBankView.ROUTE_NAME),
                        header: "Account",
                        actions: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                IconButton(
                                    iconSize: 32,
                                    icon: Icon(Icons.add_circle,
                                        color: IjudiColors.color4),
                                    onPressed: null),
                                Text("TopUp",
                                    style: IjudiStyles.CARD_ICON_BUTTON)
                              ],
                            ),
                            Padding(padding: EdgeInsets.only(left: 8)),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                IconButton(
                                    iconSize: 32,
                                    icon: Icon(Icons.monetization_on,
                                        color: IjudiColors.color2),
                                    onPressed: null),
                                Text("Withdraw",
                                    style: IjudiStyles.CARD_ICON_BUTTON)
                              ],
                            )
                          ],
                        ),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text("Current Balance",
                                      style: IjudiStyles.CARD_DISCR),
                                  Padding(padding: EdgeInsets.only(left: 16)),
                                  Text("R ${userProfile.bank.currentBalance}",
                                      style: IjudiStyles.CARD_DISCR_ITAL)
                                ],
                              ),
                              Padding(padding: EdgeInsets.only(bottom: 4)),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text("Available Balance",
                                      style: IjudiStyles.CARD_DISCR),
                                  Text("R ${userProfile.bank.availableBalance}",
                                      style: IjudiStyles.CARD_DISCR_ITAL)
                                ],
                              ),
                              Padding(padding: EdgeInsets.only(bottom: 4)),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text("Card Number",
                                      style: IjudiStyles.CARD_DISCR),
                                  Text("${userProfile.bank.account}",
                                      style: IjudiStyles.CARD_DISCR_ITAL)
                                ],
                              )
                            ])),
                    buildProfileCard(
                        header: "Stores And Services",
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("Phumlani Dube",
                                  style: IjudiStyles.CARD_DISCR),
                              Text("Age: 26 Dube",
                                  style: IjudiStyles.CARD_DISCR),
                              Text("ID Number: 9401216110082",
                                  style: IjudiStyles.CARD_DISCR),
                              Text("Email: pdube@gmail.com",
                                  style: IjudiStyles.CARD_DISCR)
                            ])),
                    buildProfileCard(
                        header: "Reviews and Ratings",
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("Phumlani Dube",
                                  style: IjudiStyles.CARD_DISCR),
                              Text("Age: 26 Dube",
                                  style: IjudiStyles.CARD_DISCR),
                              Text("ID Number: 9401216110082",
                                  style: IjudiStyles.CARD_DISCR),
                              Text("Email: pdube@gmail.com",
                                  style: IjudiStyles.CARD_DISCR)
                            ]))
                  ],
                ))
          ],
        ));
  }

  Widget buildProfileCard(
      {String header, Widget child, Widget actions, Function action}) {
    actions = actions == null ? Container() : actions;
    return IJudiCard(
        child: Container(
      margin: EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 16),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(header, style: IjudiStyles.CARD_HEADER),
            Padding(padding: EdgeInsets.only(bottom: 14)),
            child,
            Padding(padding: EdgeInsets.only(bottom: 8)),
            actions
          ]),
    ));
  }
}
