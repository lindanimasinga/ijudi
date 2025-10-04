import 'package:flutter/material.dart';
import 'package:ijudi/components/floating-action-button-with-progress.dart';
import 'package:ijudi/components/ijudi-address-input-field.dart';
import 'package:ijudi/components/ijudi-form.dart';
import 'package:ijudi/components/ijudi-input-field.dart';
import 'package:ijudi/components/mv-stateful-widget.dart';
import 'package:ijudi/components/scrollable-parent-container.dart';
import 'package:ijudi/util/theme-utils.dart';
import 'package:ijudi/util/util.dart';
import 'package:ijudi/viewmodel/register-view-model.dart';

class RegisterView extends MvStatefulWidget<RegisterViewModel> {
  static const ROUTE_NAME = "register";

  RegisterView({required RegisterViewModel viewModel}) : super(viewModel);

  @override
  Widget build(BuildContext context) {
    final Brightness brightnessValue =
        MediaQuery.of(context).platformBrightness;
    bool isLight = brightnessValue == Brightness.light;

    return ScrollableParent(
      hasDrawer: false,
      appBarColor: IjudiColors.color1,
      title: "Contact Info",
      child: Stack(
        children: <Widget>[
          Headers.getHeader(context),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 16, top: 24, bottom: 16),
                  child:
                      Text("Profile Picture", style: IjudiStyles.SUBTITLE_1),
                ),
                FittedBox(
                  fit: BoxFit.contain,
                  child: Container(
                    width: 130,
                    height: 130,
                    margin: EdgeInsets.all(0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(75),
                          bottomRight: Radius.circular(75)),
                      color: isLight
                          ? Colors.white
                          : Theme.of(context).colorScheme.background,
                      border: Border.all(
                        color: IjudiColors.color1,
                        width: 4,
                      ),
                      image: DecorationImage(
                        image: NetworkImage(viewModel.imageUrl),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16, top: 24, bottom: 16),
                  child: Text("Personal Information",
                      style: IjudiStyles.HEADER_TEXT),
                ),
                IjudiForm(
                  child: AutofillGroup(
                    child: Column(
                      children: <Widget>[
                        IjudiInputField(
                          hint: 'SA Mobile Number',
                          autofillHints: [
                            AutofillHints.telephoneNumber,
                            AutofillHints.telephoneNumberLocal
                          ],
                          text: viewModel.mobileNumber,
                          onChanged: (number) =>
                              viewModel.mobileNumber = number,
                          type: TextInputType.phone,
                        ),
                        IjudiInputField(
                            text: viewModel.name,
                            onChanged: (name) => viewModel.name = name,
                            autofillHints: [AutofillHints.name],
                            hint: 'Name',
                            type: TextInputType.text),
                        IjudiInputField(
                            text: viewModel.lastname,
                            onChanged: (lastname) =>
                                viewModel.lastname = lastname,
                            hint: 'Surname',
                            autofillHints: [AutofillHints.familyName],
                            type: TextInputType.text),
                        if (viewModel.isFirstTimeUser)
                          IjudiAddressInputField(
                              text: viewModel.address,
                              onTap: (address) => viewModel.address = address,
                              hint: 'Physical Address',
                              type: TextInputType.text),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: 16, right: 16, top: 16, bottom: 16),
                  child: Text(
                    viewModel.ukhesheMessage,
                    style: IjudiStyles.SUBTITLE_2,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
                  child: InkWell(
                    child: RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: "iZinga Food Market Terms and Conditions",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.blue))
                      ]),
                    ),
                    onTap: () => Utils.launchURLInCustomeTab(context,
                        url:
                            "https://www.iubenda.com/privacy-policy/83133872/legal"),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 16, bottom: 16),
                  child: FloatingActionButtonWithProgress(
                    viewModel: viewModel.progressMv,
                    onPressed: () {
                      if (viewModel.allFieldsValid) {
                        viewModel.signupUser();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: IjudiColors.color2,
                            content: Text(
                                'Some fields are missing or invalid.')));
                      }
                    },
                    child: Icon(Icons.check),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
