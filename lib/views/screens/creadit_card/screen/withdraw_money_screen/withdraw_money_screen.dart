import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:lekra/controllers/card_money_controller/credit_card_controller.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/custom_text.dart';
import 'package:lekra/services/theme.dart';
import 'package:lekra/views/base/common_button.dart';
import 'package:lekra/views/screens/creadit_card/screen/withdraw_verify_otp_screen/withdraw_verify_otp_screen.dart';
import 'package:lekra/views/screens/widget/text_box/app_text_box.dart';

class WithdrawMoneyScreen extends StatelessWidget {
  WithdrawMoneyScreen({
    super.key,
  });

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
            iconTheme: const IconThemeData(
              color: Colors.black,
            ),
            title: CustomText(
              'Withdraw Money',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF101B5C),
              ),
            ),
          ),
          body: SafeArea(
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                padding: AppConstants.screenPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: CustomText(
                        'Enter amount and card details',
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: greyDark,
                        ),
                      ),
                    ),

                    sizedBoxHeight(
                      height: 18,
                    ),

                    // ==================================================
                    // WITHDRAW AMOUNT
                    // ==================================================

                    _WithdrawAmountCard(
                      controller: controller,
                    ),

                    sizedBoxHeight(
                      height: 20,
                    ),

                    // ==================================================
                    // CARD INFORMATION
                    // ==================================================

                    CustomText(
                      'Credit Card Information',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: black,
                      ),
                    ),

                    sizedBoxHeight(
                      height: 10,
                    ),

                    _CreditCardForm(
                      controller: controller,
                    ),

                    sizedBoxHeight(
                      height: 22,
                    ),

                    // ==================================================
                    // WITHDRAW BUTTON
                    // ==================================================

                    CustomButton(
                      title: 'Withdraw Money (Send OTP)',
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
                            context: context, page: WithdrawVerifyOtpScreen());
                        // final bool valid =
                        //     formKey.currentState?.validate() ?? false;

                        // controller.calculateAmount();

                        // if (!valid) {
                        //   return;
                        // }

                        // if (!controller.isAmountValid) {
                        //   _showMessage(
                        //     context,
                        //     'Please enter a valid withdrawal amount',
                        //   );
                        //   return;
                        // }

                        // controller.submitWithdrawal();

                        // if (!controller.isCardValid) {
                        //   _showMessage(
                        //     context,
                        //     'Please enter valid card details',
                        //   );
                        //   return;
                        // }

                        // API will be connected later.
                        //
                        // navigate(
                        //   context: context,
                        //   page:
                        //       WithdrawVerifyOtpScreen(),
                        // );
                      },
                    ),

                    sizedBoxHeight(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _showMessage(
    BuildContext context,
    String message,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}

// ==================================================================
// WITHDRAW AMOUNT CARD
// ==================================================================

class _WithdrawAmountCard extends StatelessWidget {
  final CreditCardController controller;

  const _WithdrawAmountCard({
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: const Color(0xFFE5E9F2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            'Enter Withdraw Amount',
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w700,
              color: black,
            ),
          ),
          sizedBoxHeight(
            height: 8,
          ),
          AppTextFieldWithHeading(
            controller: controller.amountController,
            hindText: '0.00',
            prefixText: '₹  ',
            prefixStyle: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: primaryColor,
            ),
            keyboardType: const TextInputType.numberWithOptions(
              decimal: true,
            ),
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                RegExp(r'^\d*\.?\d{0,2}'),
              ),
            ],
            bgColor: white,
            borderColor: primaryColor,
            borderWidth: 1,
            borderRadius: 8,
            onChanged: (_) {
              controller.calculateAmount();
            },
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter withdrawal amount';
              }

              final double? amount = double.tryParse(
                value.trim(),
              );

              if (amount == null) {
                return 'Please enter a valid amount';
              }

              if (amount < controller.minimumAmount) {
                return 'Minimum amount is ₹${controller.minimumAmount.toStringAsFixed(0)}';
              }

              if (amount > controller.maximumAmount) {
                return 'Maximum amount is ₹${controller.maximumAmount.toStringAsFixed(0)}';
              }

              if (amount > controller.availableLimit) {
                return 'Amount exceeds available limit';
              }

              return null;
            },
          ),
          sizedBoxHeight(
            height: 12,
          ),
          _amountRow(
            'Min. Amount',
            '₹1,000',
          ),
          _amountRow(
            'Max. Amount',
            '₹1,00,000',
          ),
          _amountRow(
            'Available Limit',
            '₹1,50,000',
          ),
          _amountRow(
            'Processing Fee',
            '2.00% + GST',
          ),
          sizedBoxHeight(
            height: 6,
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: 10.w,
              vertical: 10.h,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F6FF),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  'You Will Get',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                    color: primaryColor,
                  ),
                ),
                CustomText(
                  '₹${controller.willGet.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF101B5C),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _amountRow(
    String title,
    String value,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 8.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            title,
            style: TextStyle(
              fontSize: 10.sp,
              color: const Color(
                0xFF27366F,
              ),
            ),
          ),
          CustomText(
            value,
            style: TextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.w600,
              color: const Color(
                0xFF101B5C,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ==================================================================
// CREDIT CARD FORM
// ==================================================================

class _CreditCardForm extends StatelessWidget {
  final CreditCardController controller;

  const _CreditCardForm({
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: const Color(0xFFE5E9F2),
        ),
      ),
      child: Column(
        children: [
          AppTextFieldWithHeading(
            controller: controller.cardNumberController,
            heading: 'Card Number',
            hindText: '1234 5678 9012 3456',
            keyboardType: TextInputType.number,
            maxLength: 19,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              _CardNumberFormatter(),
            ],
            validator: (value) {
              final number = value?.replaceAll(
                    ' ',
                    '',
                  ) ??
                  '';

              if (number.isEmpty) {
                return 'Please enter card number';
              }

              if (number.length != 16) {
                return 'Please enter a valid card number';
              }

              return null;
            },
          ),
          sizedBoxHeight(
            height: 14,
          ),
          Row(
            children: [
              Expanded(
                child: AppTextFieldWithHeading(
                  controller: controller.expiryDateController,
                  heading: 'Expiry Date',
                  hindText: 'MM/YY',
                  keyboardType: TextInputType.number,
                  maxLength: 5,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Required';
                    }

                    if (!RegExp(
                      r'^(0[1-9]|1[0-2])\/\d{2}$',
                    ).hasMatch(
                      value.trim(),
                    )) {
                      return 'Invalid';
                    }

                    return null;
                  },
                ),
              ),
              sizedBoxWidth(width: 12),
              Expanded(
                child: AppTextFieldWithHeading(
                  controller: controller.cvvController,
                  heading: 'CVV',
                  hindText: '123',
                  keyboardType: TextInputType.number,
                  maxLength: 3,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.length != 3) {
                      return 'Invalid CVV';
                    }

                    return null;
                  },
                ),
              ),
            ],
          ),
          sizedBoxHeight(
            height: 14,
          ),
          AppTextFieldWithHeading(
            controller: controller.cardHolderNameController,
            heading: 'Card Holder Name',
            hindText: 'Enter card holder name',
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter card holder name';
              }

              return null;
            },
          ),
        ],
      ),
    );
  }
}

// ==================================================================
// CARD NUMBER FORMATTER
// ==================================================================

class _CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final String digits = newValue.text.replaceAll(' ', '');

    final StringBuffer buffer = StringBuffer();

    for (int i = 0; i < digits.length; i++) {
      if (i > 0 && i % 4 == 0) {
        buffer.write(' ');
      }

      buffer.write(digits[i]);
    }

    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(
        offset: buffer.length,
      ),
    );
  }
}
