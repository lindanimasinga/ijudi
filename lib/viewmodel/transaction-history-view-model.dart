import 'package:ijudi/model/transaction.dart';
import 'package:ijudi/model/profile.dart';
import 'package:ijudi/viewmodel/base-view-model.dart';

class TransactionHistoryViewModel extends BaseViewModel {

  List<Transaction> _transacions = [];
  List<Transaction> _filteredTransactions = [];

  final Bank wallet;

  TransactionHistoryViewModel({required this.wallet});

  @override
  void initialize() {
  }

  List<Transaction> get transacions => _transacions;
  set transacions(List<Transaction> transacions) {
    _transacions = transacions;
    notifyChanged();
  }

  List<Transaction> get filteredTransactions => _filteredTransactions;
  set filteredTransactions(List<Transaction> filteredTransactions) {
    _filteredTransactions = filteredTransactions;
    notifyChanged();
  }

  set filter(String filter) {
    filteredTransactions = transacions
    .where((item) => item.description.contains(filter))
    .toList();
    notifyChanged();
  }

}