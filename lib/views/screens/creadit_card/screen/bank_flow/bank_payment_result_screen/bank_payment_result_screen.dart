import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/theme.dart';
import 'package:lekra/views/screens/creadit_card/screen/bank_flow/bank_payment_result_screen/widget/bank_payment_result_action.dart';
import 'package:lekra/views/screens/creadit_card/screen/bank_flow/bank_payment_result_screen/widget/bank_payment_result_details.dart';
import 'package:lekra/views/screens/creadit_card/screen/bank_flow/bank_payment_result_screen/widget/bank_payment_result_header.dart';
import 'package:lekra/views/screens/creadit_card/screen/bank_flow/bank_payment_result_screen/widget/bank_payment_result_message.dart';

enum BankPaymentStatus {
  successful,
  pending,
  cancelled,
}

class BankPaymentResultScreen extends StatelessWidget {
  const BankPaymentResultScreen({
    super.key,
    this.status = BankPaymentStatus.successful,
  });

  final BankPaymentStatus status;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: backgroundLight,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.fromLTRB(
            16.w,
            10.h,
            16.w,
            24.h,
          ),
          child: Column(
            children: [
              BankPaymentResultHeader(
                status: status,
              ),

              sizedBoxHeight(height: 24),

              BankPaymentResultDetails(
                status: status,
              ),

              sizedBoxHeight(height: 20),

              BankPaymentResultMessage(
                status: status,
              ),

              sizedBoxHeight(height: 24),

              BankPaymentResultAction(
                status: status,
              ),
            ],
          ),
        ),
      ),
    );
  }
}