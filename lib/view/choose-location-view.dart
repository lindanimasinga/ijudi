import 'package:flutter/material.dart';
import 'package:ijudi/components/bread-crumb.dart';
import 'package:ijudi/components/floating-action-button-with-progress.dart';
import 'package:ijudi/components/ijudi-address-input-field.dart';
import 'package:ijudi/components/ijudi-form.dart';
import 'package:ijudi/components/mv-stateful-widget.dart';
import 'package:ijudi/util/theme-utils.dart';
import 'package:ijudi/viewmodel/choose-location-viewmodel.dart';
import 'package:simple_animations/simple_animations.dart';

class ChooseLocationView extends MvStatefulWidget<ChooseLocationViewModel> {
  static const ROUTE_NAME = "choose-location";

  ChooseLocationView(ChooseLocationViewModel viewModel) : super(viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: IjudiColors.clear,
        ),
        body: buildStep(context,
            index: 1,
            color: IjudiColors.color3,
            title: "Pick your location bubble to view nearby shops.",
            message:
                "Find your nearest shops you can order simply using your mobile number and a digital wallet. Keep your cash in a digital wallet you can use anywhere anytime.",
            img: "assets/images/izinga-logo.png"));
  }

  Container buildStep(BuildContext context,
      {required int index,
      required String img,
      required String title,
      required String message,
      required Color color}) {
    final Brightness brightnessValue =
        MediaQuery.of(context).platformBrightness;
    bool isLight = brightnessValue == Brightness.light;
    var background = Theme.of(context).scaffoldBackgroundColor;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          tileMode: TileMode.mirror,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            background,
            background,
          ],
          stops: [
            0,
            1,
          ],
        ),
        backgroundBlendMode: BlendMode.srcOver,
      ),
      child: Stack(children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                alignment: Alignment.center,
                child:
                    Image.asset("assets/images/izinga-logo.png", width: 150)),
            Container(
                margin:
                    EdgeInsets.only(left: 16, bottom: 16, right: 16, top: 48),
                child: Text(
                  "Enter your address to find nearest stores",
                  style: IjudiStyles.HEADER_2,
                )),
            IjudiForm(
                child: IjudiAddressInputField(
                    hint: "Street Address",
                    enabled: true,
                    text: viewModel.supportedLocation?.name,
                    color: IjudiColors.color5,
                    onTap: (value) => viewModel.supportedLocation = value)),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 16),
              child: FloatingActionButtonWithProgress(
                viewModel: viewModel.progressMv,
                onPressed: () => viewModel.viewShops(),
                child: Icon(Icons.arrow_forward),
              ),
            )
          ],
        )
      ]),
    );
  }
/*
  Future.delayed(Duration(milliseconds: 500), () {
          Navigator.pushNamedAndRemoveUntil(
              context, AllShopsView.ROUTE_NAME, (Route<dynamic> route) => false,
              arguments: particle.location);
        }); */
}
