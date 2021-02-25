import 'dart:math';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ijudi/services/impl/shared-pref-storage-manager.dart';
import 'package:ijudi/util/theme-utils.dart';
import 'package:ijudi/view/all-shops-view.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:simple_animations/simple_animations.dart';

class IntroductionView extends StatefulWidget {
  static const ROUTE_NAME = "introduction";

  @override
  _IntroductionViewState createState() => _IntroductionViewState();
}

class _IntroductionViewState extends State<IntroductionView> {
  final PageController _controller = PageController(
    initialPage: 0,
  );
  int _currentPage = 0;
  final Random random = Random();
  final List<ParticleModel> particles = [];
  SharedPrefStorageManager sharedPrefStorageManager;

  @override
  void initState() {
    List.generate(30, (index) {
      particles.add(ParticleModel(random));
    });
    SharedPrefStorageManager.singleton()
        .then((value) => sharedPrefStorageManager = value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: LiquidSwipe(
      enableSlideIcon: true,
      enableLoop: false,
      positionSlideIcon: 0.815,
      slideIconWidget: currentPage == 3
          ? IconButton(
              icon: Icon(Icons.check, size: 32, color: Colors.white),
              onPressed: () {
                sharedPrefStorageManager.viewedIntro = true;
                Navigator.popAndPushNamed(context, AllShopsView.ROUTE_NAME);
              })
          : IconButton(
              icon: Icon(Icons.arrow_back, size: 32, color: Colors.white),
              onPressed: null),
      onPageChangeCallback: (value) => currentPage = value,
      pages: <Container>[
        buildStep(
            index: 1,
            color: IjudiColors.color3,
            title: "Cashless, Cardless food market",
            message:
                "Find your nearest shops you can order simply using your mobile number and a digital wallet. Keep your cash in a digital wallet you can use anywhere anytime.",
            img: "assets/images/stores.png"),
        buildStep(
            index: 2,
            color: IjudiColors.color2,
            title:
                "The most affordable wallet to keep your money for daily meals or to receive payments",
            message:
                "You can keep your money in a digital wallet to buy your daily meals. If you are a shop, you can receive payment for orders into your wallet at your convenience.",
            img: "assets/images/wallet-snap.png"),
        buildStep(
            index: 3,
            color: IjudiColors.color1,
            title: "Pay in store for groceries at your convenience",
            message:
                "You can pay in store simple by searching the name of the shop within the app and pay for groceries.",
            img: "assets/images/quick-pay.png"),
        Container(
            child: GestureDetector(
                onTap: () {
                  sharedPrefStorageManager.viewedIntro = true;
                  Navigator.popAndPushNamed(context, AllShopsView.ROUTE_NAME);
                },
                onHorizontalDragEnd: (value) => print(value),
                child: buildStep(
                    index: 4,
                    color: IjudiColors.color4,
                    message:
                        "Find your nearest shops you can order simply using your mobile number and a digital wallet.Keep your cash in a digital wallet you can use anywhere anytime.",
                    title:
                        "Receive orders, manage your stock and understand your customers better with analytics",
                    img: "assets/images/orders.png")))
      ],
    ));
  }

  Container buildStep(
      {int index, String img, String title, String message, Color color}) {
    final Brightness brightnessValue =
        MediaQuery.of(context).platformBrightness;
    bool isLight = brightnessValue == Brightness.light;
    var background = isLight
        ? color
        : index % 2 == 0
            ? Theme.of(context).scaffoldBackgroundColor
            : IjudiColors.color5;
    return Container(
        padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
        color: background,
        child: Stack(children: [
          Positioned.fill(child: buildParticles(context)),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  margin: EdgeInsets.only(top: 56),
                  child: Image.asset(img, height: 350)),
              Text(
                title,
                style: IjudiStyles.HEADER_1_MEDIUM,
                textAlign: TextAlign.center,
              ),
              Text(
                message,
                style: IjudiStyles.HEADER_TEXT,
                textAlign: TextAlign.center,
              ),
              Text(
                "$index of 4",
                style: IjudiStyles.HEADER_TEXT,
                textAlign: TextAlign.center,
              )
            ],
          ),
        ]));
  }

  Widget buildParticles(BuildContext context) {
    return Rendering(
      startTime: Duration(seconds: 30),
      onTick: _simulateParticles,
      builder: (context, time) {
        _simulateParticles(time);
        return CustomPaint(
          painter: ParticlePainter(particles, time),
        );
      },
    );
  }

  int get currentPage => _currentPage;
  set currentPage(int currentPage) {
    _currentPage = currentPage;
    setState(() {});
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

  ParticleModel(this.random) {
    restart();
  }

  restart({Duration time = Duration.zero}) {
    final startPosition = Offset(-0.2 + 1.4 * random.nextDouble(), 1.2);
    final endPosition = Offset(-0.2 + 1.4 * random.nextDouble(), -0.2);
    final duration = Duration(milliseconds: 1000 + random.nextInt(20000));

    tween = MultiTrackTween([
      Track("x").add(
          duration, Tween(begin: startPosition.dx, end: endPosition.dx),
          curve: Curves.easeInOutSine),
      Track("y").add(
          duration, Tween(begin: startPosition.dy, end: endPosition.dy),
          curve: Curves.easeIn),
    ]);
    animationProgress = AnimationProgress(duration: duration, startTime: time);
    size = 0.05 + random.nextDouble() * 0.1;
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

  ParticlePainter(this.particles, this.time);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withAlpha(50);

    particles.forEach((particle) {
      var progress = particle.animationProgress.progress(time);
      final animation = particle.tween.transform(progress);
      final position =
          Offset(animation["x"] * size.width, animation["y"] * size.height);
      canvas.drawCircle(position, size.width * 0.2 * particle.size, paint);
    });
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
