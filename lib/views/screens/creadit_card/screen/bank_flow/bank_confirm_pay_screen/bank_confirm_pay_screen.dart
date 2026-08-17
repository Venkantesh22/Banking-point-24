import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/theme.dart';
import 'package:lekra/views/base/common_button.dart';
import 'package:lekra/views/screens/creadit_card/screen/bank_flow/bank_confirm_pay_screen/widget/bank_confirm_pay_header.dart';
import 'package:lekra/views/screens/creadit_card/screen/bank_flow/bank_confirm_pay_screen/widget/bank_customer_details.dart';
import 'package:lekra/views/screens/creadit_card/screen/bank_flow/bank_confirm_pay_screen/widget/bank_payment_details.dart';
import 'package:lekra/views/screens/creadit_card/screen/bank_flow/bank_confirm_pay_screen/widget/bank_secure_message.dart';

class BankConfirmPayScreen extends StatelessWidget {
  const BankConfirmPayScreen({
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
              const BankConfirmPayHeader(),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      const BankCustomerDetails(),
                      sizedBoxHeight(height: 16),
                      const BankPaymentDetails(),
                      sizedBoxHeight(height: 22),
                    ],
                  ),
                ),
              ),
              const BankSecureMessage(),
              sizedBoxHeight(height: 18),
              CustomButton(
                title: 'Send Money',
                type: ButtonType.primary,
                onTap: () {
                  debugPrint('Bank settlement - Send Money');
                },
                height: 52.h,
                radius: 14.r,
                borderWidth: 0,
                fontSize: 14.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
