import 'package:flutter/cupertino.dart';
import 'package:ijudi/api/api-service.dart';
import 'package:ijudi/components/profile-header-component.dart';
import 'package:ijudi/components/scrollable-parent-container.dart';
import 'package:ijudi/model/profile.dart';
import 'package:ijudi/model/userProfile.dart';
import 'package:ijudi/util/theme-utils.dart';

class PersonalAndBankView extends StatefulWidget {
  
  static const ROUTE_NAME = "personal";

  @override
  _PersonalAndBankViewState createState() => _PersonalAndBankViewState();
}

class _PersonalAndBankViewState extends State<PersonalAndBankView> {
  
  UserProfile userProfile;

  @override
  void initState() {
    userProfile = ApiService.findUserById("idfrom memry");
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return ScrollableParent(
      hasDrawer: false,
      appBarColor: IjudiColors.color1,
      title: "Profile",
      child: Stack(
        children: <Widget>[
          Headers.getHeader(context),
          Container(
            margin: EdgeInsets.only(right: 16),
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: ProfileHeaderComponent(
                    profile: userProfile,
                    profilePicBorder: IjudiColors.color3
                  )
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16, top: 24, bottom: 16),
                  child: Text("Personal", 
                            style: IjudiStyles.SUBTITLE_1
                          ),
                ),
                Forms.create(
                  child: Column(
                          children: <Widget>[
                            Forms.inputField(hint: 'Cell Number', type: TextInputType.phone, text: userProfile.mobileNumber),
                            Forms.inputField(hint: 'Name', type: TextInputType.text, text: userProfile.name),
                            Forms.inputField(hint: 'Surname', type: TextInputType.text, text: userProfile.description),
                            Forms.inputField(hint: 'Id Number', type: TextInputType.text, text: userProfile.idNumber),
                            Forms.inputField(hint: 'Address', type: TextInputType.number, text: userProfile.address)
                          ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16, top: 24, bottom: 16),
                  child: Text("Bank", 
                            style: IjudiStyles.SUBTITLE_2
                          ),
                ),
                Forms.create( 
                  child: Column(
                          children: <Widget>[
                            Forms.inputField(hint: 'Bank Name', type: TextInputType.text, text: userProfile.bank.name),
                            Forms.inputField(hint: 'Account Number', type: TextInputType.text, text: userProfile.bank.account),
                            Forms.inputField(hint: 'Account Type', type: TextInputType.text, text: userProfile.bank.type)
                          ],
                  ),
                )
              ],
            )
          )
        ],
    ));
  }
}