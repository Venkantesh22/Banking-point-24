import 'package:flutter/material.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/theme.dart';
import 'package:lekra/views/screens/creadit_card/screen/transaction_success_screen/widget/settlement_option_widget.dart';
import 'package:lekra/views/screens/creadit_card/screen/transaction_success_screen/widget/transaction_success_header.dart';
import 'package:lekra/views/screens/creadit_card/screen/transaction_success_screen/widget/transaction_summary_card.dart';


class TransactionSuccessScreen extends StatelessWidget {
  const TransactionSuccessScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: backgroundLight,

      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: AppConstants.screenPadding,
          child: Column(
            children: [
              const TransactionSuccessHeader(),

              sizedBoxHeight(height: 28),

              const TransactionSummaryCard(),

              sizedBoxHeight(height: 20),

              SettlementOptionWidget(
                onWantMoneyCash: () {
                  // Demo action
                  debugPrint('Want Money Cash clicked');
                },
                onSettlementToCustomer: () {
                  // Demo action
                  debugPrint('Settlement to Customer clicked');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}