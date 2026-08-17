import 'package:flutter/material.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/theme.dart';
import 'package:lekra/views/screens/creadit_card/screen/bank_flow/account_verified_screen/widget/account_verified_header.dart';
import 'package:lekra/views/screens/creadit_card/screen/bank_flow/account_verified_screen/widget/proceed_to_confirm_button.dart';
import 'package:lekra/views/screens/creadit_card/screen/bank_flow/account_verified_screen/widget/verified_account_details.dart';
import 'package:lekra/views/screens/creadit_card/screen/bank_flow/bank_confirm_pay_screen/bank_confirm_pay_screen.dart';

class AccountVerifiedScreen extends StatelessWidget {
  const AccountVerifiedScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundLight,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Padding(
          padding: AppConstants.screenPadding,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      const AccountVerifiedHeader(),
                      sizedBoxHeight(height: 28),
                      const VerifiedAccountDetails(),
                      sizedBoxHeight(height: 24),
                    ],
                  ),
                ),
              ),
              ProceedToConfirmButton(
                onTap: () {
                  debugPrint('Proceed to Confirm');
                  navigate(context: context, page: BankConfirmPayScreen());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
