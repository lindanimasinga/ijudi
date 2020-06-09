import 'package:flutter/material.dart';
import 'package:ijudi/components/ads-card-component.dart';
import 'package:ijudi/components/ijudi-card.dart';
import 'package:ijudi/components/ijudi-form.dart';
import 'package:ijudi/components/ijudi-input-field.dart';
import 'package:ijudi/components/scrollable-parent-container.dart';
import 'package:ijudi/components/shop-component.dart';
import 'package:ijudi/model/advert.dart';
import 'package:ijudi/util/theme-utils.dart';

class AllComponentsView extends StatelessWidget {
  
  static const String ROUTE_NAME = "judiSettings";

  @override
  Widget build(BuildContext context) {

    return ScrollableParent(title: "Ijudi",
      hasDrawer: true,
      appBarColor: IjudiColors.color1,
      child: Container( 
          alignment: Alignment.topLeft,
          child: Column(
          children: <Widget>[
            Headers.getHeader(context),
            Forms.searchField(context, hint: "search shop name, item you want to buy or service"),
            IjudiForm(
              child: Column(
                children: <Widget>[
                  IjudiInputField(hint: 'Cell Number',autofillHints: [AutofillHints.telephoneNumber], type: TextInputType.phone),
                  IjudiInputField(hint: 'Name', autofillHints: [AutofillHints.name],type: TextInputType.text),
                  IjudiInputField(hint: 'Surname', autofillHints: [AutofillHints.familyName],type: TextInputType.text),
                  IjudiInputField(hint: 'Id Number', autofillHints: [AutofillHints.creditCardNumber],type: TextInputType.text),
                ],
              ),
            ),
            Buttons.account(text: "Register"),
            Buttons.account(text: "Logout"),
            FloatingActionButton(
              heroTag: "test",
              onPressed: () => {},
              child: Icon(Icons.arrow_forward),
              ),
            Padding(padding: EdgeInsets.all(4)),
            FloatingActionButton(
              heroTag: "test2",
            onPressed: () => {},
            child: Icon(Icons.add_shopping_cart),
            ),
            Buttons.google(),
            Buttons.facebook(),
            Buttons.back(),
            Buttons.home(),
            Buttons.menu(
              context: context,  
              children: <Widget>[
                  Buttons.menuItem(text : "Shop", color: IjudiColors.color1),
                  Buttons.menuItem(text: "Profile", color: IjudiColors.color2),
                  Buttons.menuItem(text: "My Shops", color: IjudiColors.color3),
                  Buttons.menuItem(text: "Errands", color: IjudiColors.color4),
                  Buttons.menuItem(text: "Settings", color: IjudiColors.color5)
                ]
            ),
            AdsCardComponent(color: IjudiColors.color2, advert: Advert(),),
            AdsCardComponent(color: IjudiColors.color1, advert: Advert(),),
            AdsCardComponent(color: IjudiColors.color3, advert: Advert(),),
            IJudiCard()
          ]
        )
      ));
  }
}