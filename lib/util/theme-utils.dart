import 'package:flutter/material.dart';
import 'package:ijudi/components/custom-clip-path.dart';

class JudiTheme {

  final ThemeData theme = ThemeData.light().copyWith(
      backgroundColor: Color(0XFFF8F7F7),
      scaffoldBackgroundColor: Color(0XFFF8F7F7),
      primaryColor: Color(0XFFd69447),
      accentColor: Color(0XFFd69447),
      primaryColorLight: Color(0XFFd69447),
      primaryColorDark: Color(0XFFd69447),
      appBarTheme: AppBarTheme(
        color: IjudiColors.color1,

      ),
      cardTheme: CardTheme(
        shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25))
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: IjudiColors.color2
      )
    ); 

   static Widget buildFromParent({@required String title, @required Widget child})  {
     return Scaffold(
        body: CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                    title: Text(title),
                  ),
                  SliverList(delegate: SliverChildListDelegate([
                      child
                    ]
                  ))
                ],
            )
    ); 
   }
}

class Headers {

  static Widget getHeader(BuildContext context) {
    return ClipPath(
      clipper: IjudyHeaderClipPath(part: Parts.FIRST),
      child: Container(
        color: IjudiColors.color3,
        height: 444.9 + 19.8,
        width: MediaQuery.of(context).size.width,
        child: ClipPath(
                clipper: IjudyHeaderClipPath(part: Parts.SECOND),
                child: Container(
                  color: IjudiColors.color2,
                  height: 384,
                  width: 375,
                  child: ClipPath(
                    clipper: IjudyHeaderClipPath(part: Parts.THIRD),
                    child: Container(
                      color: IjudiColors.color1,
                      height: 183,
                      width: 375,
                  ),
              ),
          ),
      ),
    ));
  }
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

    static Widget menuItem({String text, Color color, bool isFirst = false, bool isLast = false, Function action}) {
      return Container(
        margin: EdgeInsets.only(bottom: 4),
        child: RaisedButton(
            color: color,
            onPressed: () => action(),
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

    static Widget google() {
      return Container(
        margin: EdgeInsets.all(4),
        child: FloatingActionButton(
            heroTag: "google",
            backgroundColor: Colors.white,
            onPressed: () => {},
              child: Image.asset("assets/images/google.jpg"),
            )); 
    }

    static Widget facebook() {
      return Container(
        margin: EdgeInsets.all(4),
        child: FloatingActionButton(
            heroTag: "facebook",
            backgroundColor: IjudiColors.facebook,
            onPressed: () => {},
              child: Image.asset("assets/images/facebook.png"),
            )); 
    }

    static Widget iconButton(Icon icon) {
      return Container(
        width: 54,
        height: 54,
        margin: EdgeInsets.all(4),
        child: FlatButton(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: IjudiColors.color2,
                width: 2
              ),
              borderRadius: BorderRadius.all(Radius.circular(27.0))),
          onPressed: () => {},
          child: icon,
        )
      ); 
    }

    static Widget back() {
      return iconButton(Icon(Icons.arrow_back, color: IjudiColors.color2,)); 
    }

    static Widget home() {
      return iconButton(Icon(Icons.home, color: IjudiColors.color2,)); 
    }
} 

class IjudiColors {
  static const color1 = Color(0XFF10a59f);
  static const color2 = Color(0XFFd66247);
  static const color3 = Color(0XFFd69447);
  static const color4 = Color(0XFF1083a5);
  static const color5 = Color(0XFF707070);
  static const facebook = Color(0XFF1778f2);
}

class IjudiStyles {

  static const HEADER_1 = TextStyle(
    fontSize: 22,
    fontFamily: "Roboto Medium",
    fontWeight: FontWeight.w500,
    color: Colors.white
  );

  static const SUBTITLE_1 = TextStyle(
    fontSize: 14,
    fontFamily: "Roboto Medium",
    color: Colors.white
  );

  static const CARD_SHOP_HEADER  = TextStyle(
    fontSize: 16,
    fontFamily: "Roboto Medium",
    fontWeight: FontWeight.bold,
    color: IjudiColors.color2
  );

  static const CARD_SHOP_DISCR = TextStyle(
    fontSize: 16,
    fontFamily: "Roboto Medium"
  );
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
            child: Padding( 
              padding: EdgeInsets.only(left: 8, right: 8, top: 16, bottom: 16),
              child: child),
          ),           
    );
  }
}