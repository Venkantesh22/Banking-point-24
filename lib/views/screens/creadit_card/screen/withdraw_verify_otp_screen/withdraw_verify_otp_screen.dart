import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:lekra/controllers/card_money_controller/credit_card_controller.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/custom_text.dart';
import 'package:lekra/services/theme.dart';
import 'package:lekra/views/base/common_button.dart';
import 'package:lekra/views/screens/creadit_card/screen/transaction_success_screen/transaction_success_screen.dart';

class WithdrawVerifyOtpScreen extends StatelessWidget {
  const WithdrawVerifyOtpScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreditCardController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: white,
          appBar: AppBar(
            backgroundColor: white,
            elevation: 0,
            centerTitle: true,
            title: CustomText(
              'Verify OTP',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF101B5C),
              ),
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
                vertical: 15.h,
              ),
              child: Column(
                children: [
                  sizedBoxHeight(
                    height: 20,
                  ),

                  // ==================================================
                  // SECURITY ICON
                  // ==================================================

                  _SecurityIcon(),

                  sizedBoxHeight(
                    height: 24,
                  ),

                  CustomText(
                    'Enter OTP',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF101B5C),
                    ),
                  ),

                  sizedBoxHeight(
                    height: 8,
                  ),

                  CustomText(
                    'We have sent a 6-digit OTP to',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: greyDark,
                    ),
                  ),

                  sizedBoxHeight(
                    height: 4,
                  ),

                  CustomText(
                    '+91 98765 43210',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: primaryColor,
                    ),
                  ),

                  sizedBoxHeight(
                    height: 30,
                  ),

                  // ==================================================
                  // OTP
                  // ==================================================

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                      6,
                      (index) {
                        return SizedBox(
                          width: 42.w,
                          height: 48.h,
                          child: TextField(
                            controller: controller.otpControllers[index],
                            keyboardType: TextInputType.number,
                            maxLength: 1,
                            textAlign: TextAlign.center,
                            onChanged: (value) {
                              controller.updateOtp();

                              if (value.isNotEmpty && index < 5) {
                                FocusScope.of(
                                  context,
                                ).nextFocus();
                              }
                            },
                            decoration: InputDecoration(
                              counterText: '',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  8.r,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  sizedBoxHeight(
                    height: 24,
                  ),

                  CustomText(
                    'Resend OTP in 00:25',
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: greyDark,
                    ),
                  ),

                  sizedBoxHeight(
                    height: 35,
                  ),

                  CustomButton(
                    title: 'Verify OTP',
                    height: 48.h,
                    radius: 8.r,
                    gradient: LinearGradient(
                      colors: [
                        primaryColor,
                        secondaryColor,
                      ],
                    ),
                    onTap: () {
                      navigate(
                          context: context, page: TransactionSuccessScreen());
                      // controller.verifyOtp();

                      // if (!controller
                      //     .isOtpVerified) {
                      //   return;
                      // }

                      // API later.
                      //
                      // navigate(
                      //   context: context,
                      //   page:
                      //       TransactionSuccessScreen(),
                      // );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// ==================================================================
// SECURITY ICON
// ==================================================================

class _SecurityIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110.w,
      height: 110.w,
      decoration: BoxDecoration(
        color: primaryColor.withValues(
          alpha: 0.05,
        ),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Container(
          width: 80.w,
          height: 80.w,
          decoration: BoxDecoration(
            color: const Color(0xFF0D48C8),
            borderRadius: BorderRadius.circular(
              20.r,
            ),
          ),
          child: Icon(
            Icons.lock_outline_rounded,
            color: white,
            size: 40.r,
          ),
        ),
      ),
    );
  }
}
