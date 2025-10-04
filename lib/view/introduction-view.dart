import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ijudi/services/impl/shared-pref-storage-manager.dart';
import 'package:ijudi/util/theme-utils.dart';
import 'package:ijudi/view/all-shops-view.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

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
  SharedPrefStorageManager? sharedPrefStorageManager;

  @override
  void initState() {
    SharedPrefStorageManager.singleton()
        .then((value) => sharedPrefStorageManager = value as SharedPrefStorageManager?);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: LiquidSwipe(
      enableLoop: false,
      positionSlideIcon: 0.815,
      slideIconWidget: currentPage == 3
          ? IconButton(
              icon: Icon(Icons.check, size: 32, color: Colors.white),
              onPressed: () {
                sharedPrefStorageManager!.viewedIntro = true;
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
                  sharedPrefStorageManager!.viewedIntro = true;
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
      {required int index, required String img, required String title, required String message, required Color color}) {
    return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            tileMode: TileMode.mirror,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              color,
              color,
            ],
            stops: [
              0,
              1,
            ],
          ),
          backgroundBlendMode: BlendMode.srcOver,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(img, width: 250),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(title, style: IjudiStyles.HEADER_2_WHITE),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(message, style: IjudiStyles.SUBTITLE_1),
            ),
          ],
        ));
  }

  int get currentPage => _currentPage;
  set currentPage(int currentPage) {
    _currentPage = currentPage;
    setState(() {});
  }
}
