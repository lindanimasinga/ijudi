import 'package:ijudi/model/order.dart';
import 'package:ijudi/view/payment-view.dart';
import 'package:ijudi/viewmodel/base-view-model.dart';

class PaymentViewModel extends BaseViewModel<PaymentView> {
  
  final Order order;

  PaymentViewModel(this.order);


}