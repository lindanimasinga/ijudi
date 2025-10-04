import 'package:flutter/material.dart';
import 'package:ijudi/components/ijudi-login-field.dart';
import 'package:ijudi/util/message-dialogs.dart';
import 'package:ijudi/util/theme-utils.dart';
import 'package:ijudi/viewmodel/base-view-model.dart';

abstract class MvStatefulWidget<T extends BaseViewModel> extends StatefulWidget
    with MessageDialogs {
  final T viewModel;

  MvStatefulWidget(this.viewModel) {
    viewModel.buildFunction = build;
    viewModel.initWidgetFunction = initialize;
    viewModel.errorBuildFunction = showError;
    viewModel.loginBuildFunction = showLogin;
  }

  @override
  State<StatefulWidget> createState() => viewModel;

  Widget build(BuildContext context);

  void initialize() {}

  void showError(BuildContext context, String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.only(left: 16, top: 16, right: 16),
          titlePadding: EdgeInsets.only(left: 16, top: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          title: Text("Message"),
          content: Text(errorMessage),
          actions: <Widget>[
            TextButton(
              child: Text("Close", style: Forms.INPUT_TEXT_STYLE),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void showLogin(BuildContext context) {
    showMessageDialog(context,
        title: "Login",
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Padding(padding: EdgeInsets.only(top: 16)),
          IjudiLoginField(
            hint: "Cell Number",
            autofillHints: [AutofillHints.username],
            type: TextInputType.number,
            color: IjudiColors.color5,
            icon: Icon(Icons.phone_android, size: 22, color: Colors.white),
            onTap: (value) => viewModel.username = value,
          ),
          IjudiLoginField(
            hint: "Password",
            autofillHints: [AutofillHints.password],
            color: IjudiColors.color5,
            icon: Icon(Icons.lock, size: 22, color: Colors.white),
            onTap: (value) => viewModel.password = value,
          ),
        ]),
        actionName: "Login",
        action: () => viewModel.login());
  }
}
