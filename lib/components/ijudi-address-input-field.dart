import 'package:flutter/material.dart';
import 'package:ijudi/util/theme-utils.dart';

import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';

class IjudiAddressInputField extends StatefulWidget {
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
      this.text = "",
      this.onTap});

  @override
  _StateIjudiAddressInputField createState() => _StateIjudiAddressInputField(
      this.hint,
      this.enabled,
      this.color,
      this.type,
      this.text,
      this.onTap);
}

class _StateIjudiAddressInputField extends State<IjudiAddressInputField> {
  static const kGoogleApiKey = "AIzaSyAZbvE4NBcJIplfzmy8cSEdSpbocBggylc";
  final GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);

  String hint;
  Color color;
  TextInputType type;
  String text = "";
  Function onChanged;
  bool enabled;
  TextEditingController controller;
  TextField addressField;

  _StateIjudiAddressInputField(
      this.hint,
      this.enabled,
      this.color,
      this.type,
      this.text,
      this.onChanged);

  @override
  Widget build(BuildContext context) {
    controller = TextEditingController.fromValue(TextEditingValue(
        text: text,
        selection:
            TextSelection.fromPosition(TextPosition(offset: text.length))));
    double width = MediaQuery.of(context).size.width > 360 ? 190 : 150;

    addressField = TextField(
                controller: controller,
                keyboardType: type,
                enabled: enabled,
                readOnly: true,
                maxLines: 4,
                onTap: () => openAddressFinder(context),
                onChanged: (value) {
                  print("changed here");
                 onChanged(value);
                },
                onSubmitted: (value) {
                  print("submitted");
                //  onTap(value);
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
        width: 90,
        height: 104,
        alignment: Alignment.centerLeft,
        child: Padding(
            padding: EdgeInsets.only(left: 8),
            child: Text(hint,
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
    Prediction p = await PlacesAutocomplete.show(
        context: context,
        apiKey: kGoogleApiKey,
        mode: Mode.fullscreen, // Mode.fullscreen
        language: "za",
        components: [Component(Component.country, "za")]);

    if (p != null) {
      // get detail (lat/lng)
      PlacesDetailsResponse detail =
          await _places.getDetailsByPlaceId(p.placeId);
      text = detail.result.formattedAddress;
      setState(() {});
      addressField.onChanged(text);
    }
  }
}
