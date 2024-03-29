import 'package:flutter/material.dart';
import 'package:ijudi/components/ijudi-form.dart';
import 'package:ijudi/model/userProfile.dart';
import 'package:ijudi/util/theme-utils.dart';
import 'package:ijudi/util/util.dart';

import 'ijudi-input-field.dart';

class UkheshePaymentComponent extends StatelessWidget {
  final UserProfile customer;

  UkheshePaymentComponent(this.customer);

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width > 360 ? 90 : 50;
    return IjudiForm(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 32, right: 16, top: 16, bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Avialable Balance", style: Forms.INPUT_TEXT_STYLE),
                  Text("R${Utils.formatToCurrency(customer.bank!.availableBalance)}", style: Forms.INPUT_TEXT_STYLE)
                ],
              )
            ),
            IjudiInputField(
                hint: "Cell Number",
                autofillHints: [AutofillHints.telephoneNumber], 
                text: customer.mobileNumber,
                color: IjudiColors.color5),
            IjudiInputField(
              hint: "Card Number",
              autofillHints: [AutofillHints.creditCardNumber],
              enabled: true,
              text: customer.bank!.accountId,
              color: IjudiColors.color5,
            ),
          ],
        )
      );
  }
}
