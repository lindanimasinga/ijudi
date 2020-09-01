import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ijudi/components/floating-action-button-with-progress.dart';
import 'package:ijudi/components/ijudi-choices-input-field.dart';
import 'package:ijudi/components/ijudi-form.dart';
import 'package:ijudi/components/ijudi-input-field.dart';
import 'package:ijudi/components/mv-stateful-widget.dart';
import 'package:ijudi/components/profile-header-component.dart';
import 'package:ijudi/components/scrollable-parent-container.dart';
import 'package:ijudi/util/theme-utils.dart';
import 'package:ijudi/viewmodel/stock-add-new-view-model.dart';

class StockAddNewView extends MvStatefulWidget<StockAddNewViewModel> {
  static const ROUTE_NAME = "/stock-add";

  StockAddNewView({StockAddNewViewModel viewModel}) : super(viewModel);

  @override
  Widget build(BuildContext context) {

        Widget from1 = IjudiForm(
          child: Column(
            children: [
              IjudiInputField(
                hint: "Name",
                text: viewModel.newItemName,
                onChanged: (value) => viewModel.newItemName = value,
              ),
              IjudiInputField(
                hint: "Description",
                lines: 3,
                text: viewModel.newItemDescription,
            onChanged: (value) => viewModel.newItemDescription = value,
          ),
          IjudiInputField(
            hint: "Price",
            text: "${viewModel.newItemPrice}",
            autofillHints: [AutofillHints.name],
            type: TextInputType.number,
            onChanged: (value) => viewModel.newItemPrice = double.parse(value),
          ),
          IjudiInputField(
            hint: "Quantity",
            text: "${viewModel.newItemQuantity}",
            autofillHints: [AutofillHints.name],
            type: TextInputType.number,
            onChanged: (value) => viewModel.newItemQuantity = int.parse(value),
          ),
        ],
      ),
    );

    List<Widget> options = [];
    for (int count = 0; count < viewModel.options.length; count++) {
      options.add(IjudiForm(
          child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: IjudiChoicesInputField(
                hint: "Sauce",
                choicesHint: "BBQ, Hot, Lemon",
                option: viewModel.options[count],
                optionNumber: count,
                onRemove: (value) => viewModel.removeOption(value)
              ))));
    }

    return ScrollableParent(
        hasDrawer: false,
        appBarColor: IjudiColors.color1,
        title: "Add/Update Stock",
        child: Stack(children: <Widget>[
          Headers.getHeader(context),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: ProfileHeaderComponent(
                    profile: viewModel.shop,
                    profilePicBorder: IjudiColors.color3)),
            from1,
            Column(children: options),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Container(
                  margin: EdgeInsets.only(bottom: 16, top: 16),
                  child: Buttons.flat(
                      label: "More Options",
                      color: IjudiColors.color5,
                      action: () => viewModel.addMoreOptions())),
              Padding(
                  padding: EdgeInsets.only(right: 16, bottom: 8),
                  child: FloatingActionButtonWithProgress(
                    viewModel: viewModel.progressMv,
                    onPressed: () => viewModel.addNewItem(),
                    child: Icon(Icons.check),
                  ))
            ])
          ])
        ]));
  }
}
