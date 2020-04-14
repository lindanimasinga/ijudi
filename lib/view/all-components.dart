import 'package:flutter/material.dart';
import 'package:ijudi/util/theme-utils.dart';

class AllComponents extends StatelessWidget {
  
  static const String ROUTE_NAME = "judiSettings";

  @override
  Widget build(BuildContext context) {

    return JudiTheme.buildFromParent(title: "Ijudi",
     child: Container( 
          alignment: Alignment.topLeft,
          child: Column(
          children: <Widget>[
            Headers.getHeader(context),
            Forms.searchField(context, "search shop name, item you want to buy or service"),
            Forms.create(context, 
              Column(
                children: <Widget>[
                  Forms.inputField(context, 'Cell Number', TextInputType.phone),
                  Forms.inputField(context, 'Password', TextInputType.visiblePassword),
                  Forms.inputField(context, 'Name', TextInputType.text),
                  Forms.inputField(context, 'Surname', TextInputType.text),
                  Forms.inputField(context, 'Id Number', TextInputType.number)
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
                  Buttons.menuItem(text : "Shop", color: IjudiColors.color1, isFirst: true),
                  Buttons.menuItem(text: "Profile", color: IjudiColors.color2),
                  Buttons.menuItem(text: "My Shops", color: IjudiColors.color3),
                  Buttons.menuItem(text: "Errands", color: IjudiColors.color4),
                  Buttons.menuItem(text: "Settings", color: IjudiColors.color5, isLast: true)
                ]
            ),
            Cards.createAd(color: IjudiColors.color2),
            Cards.createAd(color: IjudiColors.color1),
            Cards.createAd(color: IjudiColors.color3),
            Cards.shop()
          ]
        )
      ));
  }
}