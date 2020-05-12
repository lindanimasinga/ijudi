import 'dart:async';

import 'package:ijudi/viewmodel/base-view-model.dart';
import 'package:ijudi/viewmodel/final-order-view-model.dart';

class OrderProgressViewModel extends BaseViewModel {

  final FinalOrderViewModel orderViewModel;
  final int stage;
  Timer _timer;
  int _startAt;

  OrderProgressViewModel({this.orderViewModel, this.stage, int countMinutes = 0}) {
    this._startAt = countMinutes * 60;
  }

  String get countDownSeconds {
    int remainingSec = _startAt % 60;
    return remainingSec > 10 ? "$remainingSec" : "0$remainingSec";
  }

  int get countDownMinutes => _startAt ~/ 60;

  @override
  void dispose() {
    _disposeTimer();
    super.dispose();
  }

  void _disposeTimer() {
    if(_timer != null){
      _timer.cancel();
      _timer = null;
    }
  }

  startCounting() {
    _timer = new Timer.periodic(new Duration(seconds: 1), (time) {
      if(_startAt < 1) {
        orderViewModel.moveNextStage();
         _disposeTimer();
      } else {
        _startAt = _startAt - 1;
        notifyChanged();
      }
    });
  }

  bool get shouldStartCounting => !timerStarted && orderViewModel.stage == stage;

  bool get timerStarted => _timer != null;

  int get currentStage => orderViewModel.stage;

}