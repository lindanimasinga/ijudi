import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ijudi/components/custom-clip-path.dart';
import 'package:ijudi/util/util.dart';

class JudiTheme {
  final ThemeData theme = ThemeData.light().copyWith(
      backgroundColor: IjudiColors.backgroud,
      scaffoldBackgroundColor: IjudiColors.backgroud,
      primaryColor: IjudiColors.color2,
      accentColor: IjudiColors.color2,
      accentColorBrightness: Brightness.light,
      primaryColorBrightness: Brightness.light,
      appBarTheme: AppBarTheme(
          iconTheme: IconThemeData.fallback(), color: IjudiColors.backgroud),
      floatingActionButtonTheme:
          FloatingActionButtonThemeData(backgroundColor: IjudiColors.color1),
      buttonTheme: ButtonThemeData(buttonColor: Colors.white));

  final ThemeData dark = ThemeData.dark().copyWith(
      cardColor: IjudiColors.cardDark,
      dialogBackgroundColor: IjudiColors.cardDark,
      scaffoldBackgroundColor: IjudiColors.backgroundDark,
      appBarTheme: AppBarTheme(
          iconTheme: IconThemeData.fallback(),
          color: IjudiColors.backgroundDark),
      floatingActionButtonTheme:
          FloatingActionButtonThemeData(backgroundColor: IjudiColors.color1),
      buttonTheme: ButtonThemeData(buttonColor: IjudiColors.color5));
}

class Headers {
  static Widget getHeader(BuildContext context,
      {Color color1 = IjudiColors.color3,
      Color color2 = IjudiColors.color2,
      Color color3 = IjudiColors.color1}) {
    return ClipPath(
        clipper: IjudyHeaderClipPath(
            part: Parts.FIRST, waves: Utils.generateWaveNumber(3), height: 260),
        child: Container(
          color: color1,
          height: 444.9 + 19.8,
          width: MediaQuery.of(context).size.width,
          child: ClipPath(
            clipper: IjudyHeaderClipPath(
                part: Parts.SECOND,
                waves: Utils.generateWaveNumber(3),
                height: 220),
            child: Container(
              color: color2,
              height: 384,
              width: 375,
              child: ClipPath(
                clipper: IjudyHeaderClipPath(
                    part: Parts.THIRD,
                    waves: Utils.generateWaveNumber(3),
                    height: 120),
                child: Container(
                  color: color3,
                  height: 183,
                  width: 375,
                ),
              ),
            ),
          ),
        ));
  }

  static getShopHeader(BuildContext context) {
    return getHeader(context,
        color3: IjudiColors.color3,
        color1: IjudiColors.color1,
        color2: IjudiColors.color2);
  }

  static getMenuHeader(BuildContext context) {
    return ClipPath(
        clipper: IjudyHeaderClipPath(
            part: Parts.FIRST,
            waves: Utils.generateWaveNumber(1),
            height: MediaQuery.of(context).size.height * 0.06),
        child: Container(
          color: IjudiColors.color1,
          height: MediaQuery.of(context).size.height * 0.06,
          width: MediaQuery.of(context).size.width,
          child: ClipPath(
            clipper: IjudyHeaderClipPath(
                part: Parts.SECOND,
                waves: Utils.generateWaveNumber(1),
                height: 65),
            child: Container(
              color: IjudiColors.color2,
              height: 75,
              width: 375,
              child: ClipPath(
                clipper: IjudyHeaderClipPath(
                    part: Parts.THIRD,
                    waves: Utils.generateWaveNumber(1),
                    height: 35),
                child: Container(
                  color: IjudiColors.color3,
                  height: 45,
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
  static const INPUT_LABEL_STYLE = TextStyle(fontSize: 12, color: Colors.white);

  static Widget searchField(BuildContext context,
      {String? hint, Function? onChanged}) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        child: Padding(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: TextFormField(
              onChanged: (value) => onChanged!(value),
              decoration: InputDecoration(
                  hintText: hint,
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                    width: 0.001,
                  )),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                    width: 0.001,
                  ))),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            )));
  }
}

class Buttons {
  static const darkButtonTextStyle =
      TextStyle(fontSize: 16, fontWeight: FontWeight.w500);

  static const accountButtonTextStyle =
      TextStyle(color: IjudiColors.color3, fontSize: 16);

  static Widget menu(
      {BuildContext? context, List<Widget> children = const <Widget>[]}) {
    final _formKey = GlobalKey<FormState>();

    return Container(
        margin: EdgeInsets.only(top: 8, bottom: 8),
        child: Form(
            key: _formKey,
            child: Padding(
                padding: EdgeInsets.only(top: 0, bottom: 0),
                child: Column(
                  children: children,
                ))));
  }

  static Widget menuItem(
      {double height = 60,
      required String text,
      Color? color,
      Function? action}) {
    return Container(
        margin: EdgeInsets.only(bottom: 4),
        child: FlatButton(
            color: IjudiColors.clear,
            onPressed: () => action!(),
            shape: RoundedRectangleBorder(),
            child: Container(
                height: height,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Text(
                        text,
                        style: darkButtonTextStyle,
                      )
                    ]))));
  }

  static Widget account({required String text, Function? action}) {
    return Container(
        margin: EdgeInsets.only(bottom: 4),
        child: RaisedButton(
            padding: EdgeInsets.all(0),
            onPressed: () => action!(),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(25.0),
                    bottomRight: Radius.circular(25.0))),
            child: Container(
                height: 51,
                width: 128,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Text(
                        text,
                        style: accountButtonTextStyle,
                      )
                    ]))));
  }

  static Widget accountFlat({required String text, Function? action}) {
    return Container(
        margin: EdgeInsets.only(bottom: 4),
        child: FlatButton(
            padding: EdgeInsets.all(0),
            onPressed: () => action!(),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(25.0),
                    bottomRight: Radius.circular(25.0))),
            child: Container(
                height: 51,
                width: 128,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Text(
                        text,
                        style: accountButtonTextStyle,
                      )
                    ]))));
  }

  static Widget google() {
    return Container(
        margin: EdgeInsets.all(16),
        child: FloatingActionButton(
          heroTag: "google",
          backgroundColor: Colors.white,
          onPressed: () => {},
          child: Image.asset("assets/images/google.jpg"),
        ));
  }

  static Widget facebook() {
    return Container(
        margin: EdgeInsets.all(16),
        child: FloatingActionButton(
          heroTag: "facebook",
          backgroundColor: IjudiColors.facebook,
          onPressed: () => {},
          child: Image.asset("assets/images/facebook.png"),
        ));
  }

  static Widget iconButton(Icon icon,
      {Color? color, Function? onPressed, String? tag}) {
    return Container(
        margin: EdgeInsets.all(4),
        child: FloatingActionButton(
          heroTag: tag,
          backgroundColor: color,
          onPressed: () => onPressed!(),
          child: icon,
        ));
  }

  static Widget back({String? tag}) {
    return iconButton(
        Icon(
          Icons.arrow_back,
          color: IjudiColors.color2,
        ),
        tag: tag);
  }

  static Widget home() {
    return iconButton(Icon(
      Icons.home,
      color: IjudiColors.color2,
    ));
  }

  static mapsNavigate({IconData? label, Color? color, Function? action}) {
    return RaisedButton(
        onPressed: action as void Function()?,
        color: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        child: Container(
            margin: EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                Icon(
                  Icons.directions,
                  color: Colors.white,
                ),
                Padding(padding: EdgeInsets.only(right: 8)),
                Icon(label, color: Colors.white)
              ],
            )));
  }

  static flat({required String label, Function()? action, Color? color}) {
    return FlatButton(
        padding: EdgeInsets.all(0),
        color: color,
        onPressed: () => action!(),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(25.0),
                bottomRight: Radius.circular(25.0))),
        child: Container(
            height: 51,
            width: 128,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Text(
                    label,
                    style: IjudiStyles.DIALOG_WHITE,
                  )
                ])));
  }
}

class IjudiColors {
  static const color1 = Color(0XFF10a59f);
  static const color2 = Color(0XFFd66247);
  static const color3 = Color(0XFFd69447);
  static const color4 = Color(0XFF1083a5);
  static const color5 = Color(0XFF707070);
  static const color6 = Color(0XFFA2A2A2);
  static const facebook = Color(0XFF1778f2);
  static const backgroud = Color(0XFFF8F7F7);
  static const backgroundDark = Color(0XFF212121);
  static const cardDark = Color(0XFF2D2D2D);
  static const clear = Color(0X00F8F7F7);
  static const whatsappColor = Color(0XFF64B161);
  static const telkomPay = Color(0XFF0083c2);
}

class IjudiStyles {
  static const HEADER_1 = TextStyle(
      fontSize: 22,
      fontFamily: "Roboto",
      fontWeight: FontWeight.w500,
      color: Colors.white);

  static const HEADER_1_MEDIUM = TextStyle(
      fontSize: 22,
      fontFamily: "Roboto",
      fontWeight: FontWeight.normal,
      color: Colors.white);

  static const HEADER_2 = TextStyle(
    fontSize: 18,
    fontFamily: "Roboto",
  );

  static const HEADER_LG = TextStyle(fontSize: 18, fontFamily: "Roboto");

  static const HEADER_2_WHITE = TextStyle(
    fontSize: 18,
    color: Colors.white,
    fontFamily: "Roboto",
  );

  static const HEADING = TextStyle(
    fontSize: 18,
    fontFamily: "Roboto",
    fontWeight: FontWeight.w500,
  );

  static const SUBTITLE_1 =
      TextStyle(fontSize: 14, fontFamily: "Roboto", color: Colors.white);

  static const SUBTITLE_2 =
      TextStyle(fontSize: 14, fontFamily: "Roboto", color: IjudiColors.color5);

  static const CARD_SHOP_HEADER = TextStyle(
      fontSize: 16,
      fontFamily: "Roboto",
      fontWeight: FontWeight.bold,
      color: IjudiColors.color3);

  static const CARD_SHOP_HEADER2 = TextStyle(
      fontSize: 14,
      fontFamily: "Roboto",
      fontWeight: FontWeight.w500,
      color: IjudiColors.color3);

  static const CARD_HEADER = TextStyle(
      fontSize: 18,
      fontFamily: "Roboto",
      fontWeight: FontWeight.w500,
      color: IjudiColors.color5);

  static const CARD_SHOP_DISCR = TextStyle(fontSize: 14, fontFamily: "Roboto");

  static const CARD_SHOP_DISCR2 = TextStyle(fontSize: 12, fontFamily: "Roboto");

  static const CARD_DISCR =
      TextStyle(fontSize: 16, fontFamily: "Roboto", color: IjudiColors.color5);

  static const DIALOG_WHITE =
      TextStyle(fontSize: 16, fontFamily: "Roboto", color: Colors.white);

  static const DIALOG_WHITE_BOLD = TextStyle(
      fontSize: 16,
      fontFamily: "Roboto",
      fontWeight: FontWeight.w500,
      color: Colors.white);

  static const DIALOG_IMPORTANT_TEXT = TextStyle(
      fontSize: 16,
      fontFamily: "Roboto",
      fontWeight: FontWeight.w500,
      color: IjudiColors.color2);

  static const DIALOG_DARK_BOLD = TextStyle(
      fontSize: 16,
      fontFamily: "Roboto",
      fontWeight: FontWeight.w500,
      color: IjudiColors.color5);

  static const DIALOG_DARK =
      TextStyle(fontSize: 16, fontFamily: "Roboto", color: IjudiColors.color5);

  static const CARD_DISCR_ITAL =
      TextStyle(fontSize: 16, fontFamily: "Roboto", color: IjudiColors.color4);

  static const CARD_AMOUNT_DISCR = TextStyle(
      fontSize: 26,
      fontFamily: "Roboto",
      fontWeight: FontWeight.w500,
      color: IjudiColors.color4);

  static const RATING = TextStyle(
      fontSize: 19,
      fontFamily: "Roboto",
      fontStyle: FontStyle.italic,
      fontWeight: FontWeight.bold,
      color: Colors.white);

  static const RATING_DARK = TextStyle(
    fontSize: 12,
    fontFamily: "Roboto",
    fontStyle: FontStyle.italic,
    fontWeight: FontWeight.bold,
  );

  static const RATING_LABEL = TextStyle(
      fontSize: 12,
      fontFamily: "Roboto",
      fontWeight: FontWeight.w500,
      color: Colors.white);

  static const RATING_LABEL_DARK = TextStyle(
    fontSize: 12,
    fontFamily: "Roboto",
  );

  static const ITEM = TextStyle(
      fontSize: 14,
      fontFamily: "Roboto",
      fontWeight: FontWeight.w500,
      color: IjudiColors.color2);

  static const ITEM_EXCLUDED = TextStyle(
      fontSize: 12,
      fontFamily: "Roboto",
      decoration: TextDecoration.lineThrough);

  static const ITEM_INCLUDED = TextStyle(
    fontSize: 12,
    fontFamily: "Roboto",
    fontWeight: FontWeight.w500,
  );

  static const HEADER_TEXT =
      TextStyle(fontSize: 14, fontFamily: "Roboto", color: Colors.white);

  static const CONTENT_TEXT = TextStyle(
    fontSize: 14,
    fontFamily: "Roboto",
  );

  static const CARD_ICON_BUTTON = TextStyle(fontSize: 12, fontFamily: "Roboto");

  static const CARD_ICON_BUTTON_WHITE =
      TextStyle(fontSize: 12, fontFamily: "Roboto", color: Colors.white);

  static const COUNT_DOWN = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.w500,
    fontFamily: "Roboto",
  );

  static const COUNT_DOWN_LABEL = TextStyle(
    fontSize: 14,
    fontFamily: "Roboto",
  );

  static const FORM_ERROR =
      TextStyle(fontSize: 12, fontFamily: "Roboto", color: IjudiColors.color2);
}
