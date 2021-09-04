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
          title: Image.asset("assets/images/izinga-logo.png", width: 130),
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
        buildParticles(context, 4),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                margin: EdgeInsets.only(left: 16, bottom: 16, right: 16),
                child: Text(
                  "Enter your address to find nearest stores",
                  style: IjudiStyles.HEADER_LG,
                )),
            IjudiForm(
                child: IjudiAddressInputField(
                    hint: "i.e Durban North, KwaMashu, Newlands",
                    enabled: true,
                    text: viewModel.deliveryAddress,
                    color: IjudiColors.color5,
                    onTap: (value) => viewModel.deliveryAddress = value)),
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

  Widget buildParticles(BuildContext context, int numberOfParticles) {
    var pickedColor = BreadCrumb.statusColors[numberOfParticles - 1];

    return PlasmaRenderer(
        child: numberOfParticles > 1
            ? buildParticles(context, numberOfParticles - 1)
            : null,
        type: PlasmaType.circle,
        particles: 6,
        color: pickedColor,
        blur: 0,
        size: 0.18,
        speed: 1.75,
        offset: 0,
        blendMode: BlendMode.srcOver,
        particleType: ParticleType.atlas,
        variation1: 0.31,
        variation2: 0.02,
        variation3: 0.05,
        rotation: 0.9 * numberOfParticles);
  }
/*
  Future.delayed(Duration(milliseconds: 500), () {
          Navigator.pushNamedAndRemoveUntil(
              context, AllShopsView.ROUTE_NAME, (Route<dynamic> route) => false,
              arguments: particle.location);
        }); */
}
