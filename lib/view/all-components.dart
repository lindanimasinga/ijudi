import 'package:flutter/material.dart';
import 'package:ijudi/util/theme-utils.dart';

class AllComponents extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return ListView(

      children: <Widget>[
        Container( 
          alignment: Alignment.topLeft,
          child: Column(
          children: <Widget>[
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
              onPressed: () => {},
              child: Icon(Icons.arrow_forward),
              ),
              FloatingActionButton(
              onPressed: () => {},
              child: Icon(Icons.add_shopping_cart),
              ),
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
      )
    ]
    );
  }
}