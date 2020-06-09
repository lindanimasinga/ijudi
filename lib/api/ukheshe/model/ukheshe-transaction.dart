
import 'package:ijudi/model/transaction.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ukheshe-transaction.g.dart';

@JsonSerializable()
class UkhesheTransaction extends Transaction {
    
  
  UkhesheTransaction(DateTime date, double amount, String description, String type, String subType)
   : super(date, amount, description, type, subType);

  factory UkhesheTransaction.fromJson(Map<String, dynamic> json) => _$UkhesheTransactionFromJson(json);
}