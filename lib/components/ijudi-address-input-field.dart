import 'package:flutter/material.dart';
import 'package:ijudi/util/theme-utils.dart';

import 'package:flutter_places/flutter_places.dart';
import 'package:google_maps_webservice/places.dart';

class IjudiAddressInputField extends StatelessWidget {
  
  static const kGoogleApiKey = "AIzaSyAZbvE4NBcJIplfzmy8cSEdSpbocBggylc";
  final GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);

  final String hint;
  final Color color;
  final TextInputType type;
  final String text;
  final Function onTap;
  final bool enabled;

  IjudiAddressInputField(
      {@required this.hint,
      this.enabled,
      this.color = IjudiColors.color5,
      this.type,
      @required this.text,
      @required this.onTap});

  TextField addressField;

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = text == null? null : TextEditingController.fromValue(TextEditingValue(
        text: text,
        selection:
            TextSelection.fromPosition(TextPosition(offset: text.length))));
    double width = MediaQuery.of(context).size.width > 360 ? 166 : 126;
    double width2 = MediaQuery.of(context).size.width > 360 ? 114 : 114;

    addressField = TextField(
                controller: controller,
                keyboardType: type,
                enabled: enabled,
                readOnly: true,
                maxLines: 4,
                onTap: () => openAddressFinder(context),
                onChanged: (value) {
                  print("changed here");
                },
                onSubmitted: (value) {
                  print("submitted");
                  onTap(value);
                },
                decoration: InputDecoration(
                    hintText: hint,
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                      width: 0.01,
                    ))),
              );

    return Row(children: <Widget>[
      Container(
        color: color,
        width: width2,
        height: 104,
        alignment: Alignment.centerLeft,
        child: Padding(
            padding: EdgeInsets.only(left: 16, right: 4),
            child: Text(hint,
                maxLines: 2,
                style: Forms.INPUT_LABEL_STYLE,
                overflow: TextOverflow.ellipsis)),
      ),
      Container(
          width: width,
          child: Padding(
              padding: EdgeInsets.only(left: 8, top: 4, bottom: 0),
              child: addressField))
    ]);
  }

  openAddressFinder(BuildContext context) async {
    print("finding address....");

    Place p = await FlutterPlaces.show(
                    context: context,
                    apiKey: kGoogleApiKey,
                    modeType: ModeType.OVERLAY,
                  );    

    if (p != null) {
      // get detail (lat/lng)
      addressField.onSubmitted(p.placeDetails.formattedAddress);
    }
  }
}
