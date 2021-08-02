import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ijudi/api/api-service.dart';
import 'package:ijudi/model/selection-option.dart';
import 'package:ijudi/model/shop.dart';
import 'package:ijudi/model/stock.dart';
import 'package:ijudi/viewmodel/base-view-model.dart';

class StockAddNewViewModel extends BaseViewModel {
  final StockAddNewInput inputData;
  final ApiService apiService;

  String newItemName;
  double newItemPrice = 0;
  int newItemQuantity = 0;
  String newItemDescription;

  List<SelectionOption> options = [];

  StockAddNewViewModel({this.inputData, @required this.apiService});

  @override
  initialize() {
    if (inputData.stock != null) {
      newItemName = inputData.stock.name;
      newItemPrice = inputData.stock.price;
      newItemQuantity = inputData.stock.quantity;
      newItemDescription = inputData.stock.description;
      options = inputData.stock.mandatorySelection != null
          ? inputData.stock.mandatorySelection
          : [];
    }
  }

  addNewItem() {
    log("otions are ${options.map((e) => e.name).toList().toString()}");
    progressMv.isBusy = true;
    var stock = Stock(
      name: newItemName,
      storePrice: newItemPrice,
      quantity: newItemQuantity,
    )
      ..id = inputData.stock?.id
      ..mandatorySelection = options
      ..description = newItemDescription;

    apiService.addStockItem(inputData.shop.id, stock).asStream().listen(
        (newStock) {
      Future.delayed(Duration(seconds: 1))
          .then((value) => Navigator.pop(context));
    }, onError: (e) {
      showError(error: e);
    }, onDone: () {
      progressMv.isBusy = false;
    });

    BaseViewModel.analytics
        .logEvent(name: "shop.addStock", parameters: stock.toJson())
        .then((value) => null);
  }

  addMoreOptions() {
    options.add(SelectionOption());
    notifyChanged();
  }

  removeOption(int index) {
    log("index is $index");
    options.removeAt(index);
    log(options.map((value) => value.name).toList().toString());
    notifyChanged();
  }
}

class StockAddNewInput {
  final Shop shop;
  final Stock stock;

  StockAddNewInput(this.shop, this.stock);
}
