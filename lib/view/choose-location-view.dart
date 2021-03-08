import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ijudi/components/bread-crumb.dart';
import 'package:ijudi/components/ijudi-address-input-field.dart';
import 'package:ijudi/config.dart';
import 'package:ijudi/model/supported-location.dart';
import 'package:ijudi/services/impl/shared-pref-storage-manager.dart';
import 'package:ijudi/util/theme-utils.dart';
import 'package:ijudi/view/all-shops-view.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:touchable/touchable.dart';

class ChooseLocationView extends StatefulWidget {
  static const ROUTE_NAME = "choose-location";

  @override
  _ChooseLocationViewState createState() => _ChooseLocationViewState();
}

class _ChooseLocationViewState extends State<ChooseLocationView> {
  final Random random = Random();
  final List<ParticleModel> particles = [];
  SharedPrefStorageManager sharedPrefStorageManager;

  var deliveryAddress;

  @override
  void initState() {
    var colorPickCount = 0;
    Config.currentConfig.locations.forEach((location) {
      var pickedColor = BreadCrumb.statusColors[colorPickCount];
      colorPickCount = colorPickCount >= BreadCrumb.statusColors.length - 1
          ? 0
          : colorPickCount + 1;
      print("Selected color is $colorPickCount");
      particles.add(ParticleModel(random, location, pickedColor));
    });
    SharedPrefStorageManager.singleton()
        .then((value) => sharedPrefStorageManager = value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: IjudiColors.clear,
        ),
        body: buildStep(
            index: 1,
            color: IjudiColors.color3,
            title: "Pick your location bubble to view nearby shops.",
            message:
                "Find your nearest shops you can order simply using your mobile number and a digital wallet. Keep your cash in a digital wallet you can use anywhere anytime.",
            img: "assets/images/izinga-logo.png"));
  }

  Container buildStep(
      {int index, String img, String title, String message, Color color}) {
    return Container(
        padding: EdgeInsets.only(bottom: 16, left: 16, right: 16),
        child: Stack(children: [
          Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  margin: EdgeInsets.only(bottom: 32),
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Image.asset(img, height: 80)),
              Text(
                title,
                style: IjudiStyles.HEADER_2,
                textAlign: TextAlign.center,
              )
            ],
          )),
          Positioned.fill(child: buildParticles(context))
        ]));
  }

  Widget buildParticles(BuildContext context) {
    return Rendering(
      startTime: Duration(seconds: 10),
      onTick: _simulateParticles,
      builder: (context, time) {
        _simulateParticles(time);
        return CanvasTouchDetector(
            builder: (context) => CustomPaint(
                painter: ParticlePainter(particles, time, context)));
      },
    );
  }

  _simulateParticles(Duration time) {
    particles.forEach((particle) => particle.maintainRestart(time));
  }
}

class ParticleModel {
  Animatable tween;
  double size;
  AnimationProgress animationProgress;
  Random random;
  SupportedLocation location;
  Color color;

  ParticleModel(this.random, this.location, this.color) {
    restart();
  }

  restart({Duration time = Duration.zero}) {
    final startPosition = Offset(-0.2 + 1.4 * random.nextDouble(), 1.2);
    final endPosition = Offset(-0.2 + 1.4 * random.nextDouble(), -0.2);
    final duration = Duration(milliseconds: 10000 + random.nextInt(10000));

    tween = MultiTrackTween([
      Track("x").add(
          duration, Tween(begin: startPosition.dx, end: endPosition.dx),
          curve: Curves.easeInOutSine),
      Track("y").add(
          duration, Tween(begin: startPosition.dy, end: endPosition.dy),
          curve: Curves.easeIn),
    ]);
    animationProgress = AnimationProgress(duration: duration, startTime: time);
    size = 0.9 + random.nextDouble();
  }

  maintainRestart(Duration time) {
    if (animationProgress.progress(time) == 1.0) {
      restart(time: time);
    }
  }
}

class ParticlePainter extends CustomPainter {
  List<ParticleModel> particles;
  Duration time;
  BuildContext context;

  ParticlePainter(this.particles, this.time, this.context);

  @override
  void paint(Canvas canvas, Size size) {
    var myCanvas = TouchyCanvas(context, canvas);

    particles.forEach((particle) {
      var progress = particle.animationProgress.progress(time);
      var paint = Paint()..color = particle.color.withAlpha(230);
      final animation = particle.tween.transform(progress);
      final position =
          Offset(animation["x"] * size.width, animation["y"] * size.height);

      myCanvas.drawCircle(position, size.width * 0.2 * particle.size, paint,
          onTapDown: (tapInfo) {
        print("Tapped bubble ${particle.location} clicked");
        particle.color = IjudiColors.color5;
        Future.delayed(Duration(milliseconds: 500), () {
          Navigator.pushNamedAndRemoveUntil(
              context, AllShopsView.ROUTE_NAME, (Route<dynamic> route) => false,
              arguments: particle.location);
        });
      });

      TextSpan span = new TextSpan(
          style: IjudiStyles.CARD_SHOP_HEADER2, text: particle.location.name);
      TextPainter tp = new TextPainter(
          text: span,
          textAlign: TextAlign.left,
          textDirection: TextDirection.ltr);
      tp.layout();
      tp.paint(canvas,
          Offset(animation["x"] * size.width, animation["y"] * size.height));
    });
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
