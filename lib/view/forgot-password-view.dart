import 'package:flutter/material.dart';
import 'package:ijudi/components/floating-action-button-with-progress.dart';
import 'package:ijudi/components/ijudi-form.dart';
import 'package:ijudi/components/ijudi-login-field.dart';
import 'package:ijudi/components/mv-stateful-widget.dart';
import 'package:ijudi/components/scrollable-parent-container.dart';
import 'package:ijudi/util/theme-utils.dart';
import 'package:ijudi/viewmodel/forgot-password-view-model.dart';
import 'package:lottie/lottie.dart';

class ForgotPasswordView extends MvStatefulWidget<ForgotPasswordViewModel> {
  static const ROUTE_NAME = "forgot-password";

  ForgotPasswordView({ForgotPasswordViewModel viewModel}) : super(viewModel);

  @override
  Widget build(BuildContext context) {
    return ScrollableParent(
        hasDrawer: false,
        title: "Password Reset",
        appBarColor: IjudiColors.color1,
        child:
            Stack(
              children: <Widget>[
                Headers.getHeader(context), Container(),
                Container(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 16, right: 16, bottom: 150, top: 40),
                        child: Text(viewModel.message, 
                                style: IjudiStyles.HEADER_2_WHITE),
                                ),
                    Row(
                      children: <Widget>[
                        IjudiForm(
                          child: Column(
                            children: <Widget>[
                              IjudiLoginField(
                                  hint: "SA Mobile Number",
                                  type: TextInputType.phone,
                                  text: viewModel.mobileNumber,
                                  autofillHints: [
                                    AutofillHints.telephoneNumber,
                                    AutofillHints.telephoneNumberLocal
                                  ],
                                  icon: Icon(Icons.phone_android,
                                      size: 22, color: Colors.white),
                                  onTap: (number) =>
                                      viewModel.mobileNumber = number,
                                  color: IjudiColors.color5),
                              !viewModel.otpRequestSent ? Container() : IjudiLoginField(
                                hint: "OTP",
                                text: viewModel.otpCode,
                                icon: Icon(
                                  Icons.confirmation_number,
                                  size: 22,
                                  color: Colors.white,
                                ),
                                autofillHints: [AutofillHints.oneTimeCode],
                                onTap: (pass) => viewModel.otpCode = pass,
                                color: IjudiColors.color5,
                              ),
                              !viewModel.otpRequestSent ? Container() : IjudiLoginField(
                                hint: "Password",
                                text: viewModel.password,
                                icon: Icon(
                                  Icons.lock,
                                  size: 22,
                                  color: Colors.white,
                                ),
                                autofillHints: [AutofillHints.newPassword],
                                onTap: (pass) => viewModel.password = pass,
                                color: IjudiColors.color5,
                              ),
                              !viewModel.otpRequestSent? Container() : IjudiLoginField(
                                hint: "Confirm Password",
                                text: viewModel.passwordConfirm,
                                icon: Icon(
                                  Icons.lock,
                                  size: 22,
                                  color: Colors.white,
                                ),
                                autofillHints: [AutofillHints.newPassword],
                                onTap: (pass) => viewModel.passwordConfirm = pass,
                                color: IjudiColors.color5,
                              ),
                            ],
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(right: 16)),
                        FloatingActionButtonWithProgress(
                          viewModel: viewModel.progressMv,
                          onPressed: () {
                            if(viewModel.otpRequestSent) {
                              viewModel.passwordReset();
                            } else {
                              viewModel.requestPasswordReset();
                            }
                          },
                          child: Icon(Icons.arrow_forward),
                        )
                      ],
                    ),
                    !viewModel.changeSucessful? Container() : Container(
                      margin: EdgeInsets.only(top: 32),
                      child: Lottie.asset(
                              "assets/lottie/success.json",
                              animate: true,
                              fit: BoxFit.fill, width: 90
                            )
                    )
                  ]
                )
                )
              ]
            )
    );
  }
}
