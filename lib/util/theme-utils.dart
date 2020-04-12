import 'package:flutter/material.dart';

class JudiTheme {

  final ThemeData theme = ThemeData.light().copyWith(
      backgroundColor: Color(0XFFF8F7F7),
      scaffoldBackgroundColor: Color(0XFFF8F7F7),
      primaryColor: Color(0XFFd69447),
      accentColor: Color(0XFFd69447),
      cardTheme: CardTheme(
        shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25))
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: IjudiColors.color2
      )
    ); 
}

  class Forms {

    static const INPUT_TEXT_STYLE = TextStyle(
            fontSize: 14,
          ); 

    static Widget create(BuildContext context, Widget child) {
      
      final _formKey = GlobalKey<FormState>();

      return Container(
        width: 290,
        margin: EdgeInsets.only(top: 8, bottom: 8),
        child: Card(
          margin: EdgeInsets.all(0),
          shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(topRight: Radius.circular(25.0),
                     bottomRight: Radius.circular(25.0))),
          child: Form(
            key: _formKey,
            child: 
              Padding(
                padding: EdgeInsets.only(top: 0, bottom: 0),
                child: child,
                )
            )
        )
      );
    }

    static Widget inputField(BuildContext context, String hint, TextInputType type) {

      return Padding(padding: EdgeInsets.only(left: 8, top: 4, bottom: 0),
      child: TextFormField(
          keyboardType: type,
          decoration: InputDecoration(
            hintText: hint,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                width: 0.04,
              )
            )
          ),
          validator: (value) {
            if (value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
       ) );
    }

    static Widget searchField(BuildContext context, String hint) {

      return Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            child: Padding(
              padding: EdgeInsets.only(left: 16, right: 16), 
              child: TextFormField(
                  decoration: InputDecoration(
                    hintText: hint,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(width: 0.001,)
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(width: 0.001,)
                    )
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
              ) 
          )
      );
    }
  }

class Buttons {

    static const darkButtonTextStyle = TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.w500
    );

    static const accountButtonTextStyle = TextStyle(
      color: IjudiColors.color2,
      fontSize: 16
    );

    static Widget menu({BuildContext context, List<Widget> children = const <Widget>[]}) {
        final _formKey = GlobalKey<FormState>();

        return Container(
          width: 290,
          margin: EdgeInsets.only(top: 8, bottom: 8),
          child: Form(
              key: _formKey,
              child: 
                Padding(
                  padding: EdgeInsets.only(top: 0, bottom: 0),
                  child: Column(
                    children: children,
                  )
              )
          )
        );
    }

    static Widget menuItem({String text, Color color, bool isFirst = false, bool isLast = false}) {
      return Container(
        margin: EdgeInsets.only(bottom: 4),
        child: RaisedButton(
            color: color,
            onPressed: () => {},
            shape: isFirst ? RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(25.0))) :
                   isLast ? RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomRight: Radius.circular(25.0))) : 
                   RoundedRectangleBorder(),
            child: Container(
              height: 71,
              child : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                      Text(text, style: darkButtonTextStyle,)
                    ]
              )
            )
          )
      );
    }

    static Widget account({String text}) {
      return Container(
        margin: EdgeInsets.only(bottom: 4),
        child: RaisedButton(
            onPressed: () => {},
            shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(topRight: Radius.circular(25.0), bottomRight: Radius.circular(25.0))),
            color: Colors.white,
            child: Container(
              height: 51,
              width: 128,
              child : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                      Text(text, style: accountButtonTextStyle,)
                    ]
              )
            )
          )
      ); 
    }
} 

class IjudiColors {
  static const color1 = Color(0XFF10a59f);
  static const color2 = Color(0XFFd66247);
  static const color3 = Color(0XFFd69447);
  static const color4 = Color(0XFF1083a5);
  static const color5 = Color(0XFF707070);
}

class IjudiStyles {

}

class Cards {

  static Widget createAd({Widget child, Color color}) {
    return Card(
          color: color,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          child: Container(
            width: 284,
            height: 316,
            child: child,
          ),           
    );
  }

  static Widget shop({Widget child}) {
    return Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          child: Container(
            width: 352,
            height: 176,
            child: child,
          ),           
    );
  }
}