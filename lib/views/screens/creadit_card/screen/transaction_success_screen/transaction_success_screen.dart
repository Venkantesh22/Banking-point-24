import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:lekra/controllers/card_money_controller/credit_card_controller.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/custom_text.dart';
import 'package:lekra/services/theme.dart';

class TransactionSuccessScreen
    extends StatelessWidget {
  const TransactionSuccessScreen({
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
          ),

          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 15.h,
              ),
              child: Column(
                children: [
                  // ==================================================
                  // SUCCESS ICON
                  // ==================================================

                  _SuccessIcon(),

                  sizedBoxHeight(
                    height: 18,
                  ),

                  CustomText(
                    'Transaction Successful!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight:
                          FontWeight.w700,
                      color:
                          const Color(0xFF101B5C),
                    ),
                  ),

                  sizedBoxHeight(
                    height: 8,
                  ),

                  CustomText(
                    'Your money withdrawal request has\n'
                    'been placed successfully.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12.sp,
                      height: 1.5,
                      color: greyDark,
                    ),
                  ),

                  sizedBoxHeight(
                    height: 22,
                  ),

                  // ==================================================
                  // TRANSACTION DETAILS
                  // ==================================================

                  _TransactionDetails(
                    controller: controller,
                  ),

                  sizedBoxHeight(
                    height: 18,
                  ),

                  // ==================================================
                  // ACTION OPTIONS
                  // ==================================================

                  _TransactionActions(),

                  sizedBoxHeight(
                    height: 25,
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
// SUCCESS ICON
// ==================================================================

class _SuccessIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 92.w,
      height: 92.w,
      decoration: BoxDecoration(
        color:
            Colors.green.withValues(
          alpha: 0.12,
        ),
        shape: BoxShape.circle,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 70.w,
            height: 70.w,
            decoration:
                const BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.check_rounded,
              color: white,
              size: 42.r,
            ),
          ),
        ],
      ),
    );
  }
}

// ==================================================================
// TRANSACTION DETAILS
// ==================================================================

class _TransactionDetails
    extends StatelessWidget {
  final CreditCardController controller;

  const _TransactionDetails({
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: white,
        borderRadius:
            BorderRadius.circular(12.r),
        border: Border.all(
          color:
              const Color(0xFFE5E9F2),
        ),
      ),
      child: Column(
        children: [
          _detailRow(
            'Amount',
            '₹${controller.amountController.text.isEmpty ? '25,000.00' : controller.amountController.text}',
          ),

          _detailRow(
            'Processing Fee',
            '₹${controller.processingFee.toStringAsFixed(2)}',
          ),

          _detailRow(
            'GST',
            '₹${controller.gst.toStringAsFixed(2)}',
          ),

          Divider(
            color:
                const Color(0xFFE5E9F2),
            height: 20.h,
          ),

          _detailRow(
            'Total Debit',
            '₹${controller.totalDebit.toStringAsFixed(2)}',
            valueColor: Colors.red,
            bold: true,
          ),

          Divider(
            color:
                const Color(0xFFE5E9F2),
            height: 20.h,
          ),

          _detailRow(
            'To',
            'HDFC Bank',
            valueColor:
                const Color(0xFF101B5C),
          ),

          _detailRow(
            'A/c No.',
            'XXXX XXXX 4567',
          ),

          Divider(
            color:
                const Color(0xFFE5E9F2),
            height: 20.h,
          ),

          _detailRow(
            'Transaction ID',
            'TXN51234567890',
          ),

          _detailRow(
            'Date & Time',
            '12 May 2025 • 11:45 AM',
          ),

          Row(
            mainAxisAlignment:
                MainAxisAlignment
                    .spaceBetween,
            children: [
              CustomText(
                'Status',
                style: TextStyle(
                  fontSize: 10.sp,
                  color: greyDark,
                ),
              ),
              Container(
                padding:
                    EdgeInsets.symmetric(
                  horizontal: 10.w,
                  vertical: 5.h,
                ),
                decoration:
                    BoxDecoration(
                  color: Colors.green
                      .withValues(
                    alpha: 0.10,
                  ),
                  borderRadius:
                      BorderRadius.circular(
                    12.r,
                  ),
                ),
                child: CustomText(
                  'Successful',
                  style: TextStyle(
                    fontSize: 9.sp,
                    fontWeight:
                        FontWeight.w600,
                    color: Colors.green,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _detailRow(
    String title,
    String value, {
    Color? valueColor,
    bool bold = false,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 6.h,
      ),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: CustomText(
              title,
              style: TextStyle(
                fontSize: 10.sp,
                color: greyDark,
              ),
            ),
          ),
          Expanded(
            child: CustomText(
              value,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 10.sp,
                fontWeight: bold
                    ? FontWeight.w700
                    : FontWeight.w500,
                color: valueColor ??
                    const Color(
                      0xFF101B5C,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ==================================================================
// TRANSACTION ACTIONS
// ==================================================================

class _TransactionActions
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: white,
        borderRadius:
            BorderRadius.circular(12.r),
        border: Border.all(
          color:
              const Color(0xFFE5E9F2),
        ),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(
                  16.w,
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons
                          .payments_outlined,
                      color: Colors.green,
                      size: 30.r,
                    ),

                    sizedBoxHeight(
                      height: 7,
                    ),

                    CustomText(
                      'Want Money Cash',
                      textAlign:
                          TextAlign.center,
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight:
                            FontWeight.w600,
                        color:
                            const Color(
                          0xFF101B5C,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            VerticalDivider(
              width: 1,
              color:
                  const Color(0xFFE5E9F2),
            ),

            Expanded(
              child: Padding(
                padding: EdgeInsets.all(
                  16.w,
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.account_balance,
                      color: primaryColor,
                      size: 30.r,
                    ),

                    sizedBoxHeight(
                      height: 7,
                    ),

                    CustomText(
                      'Settlement to Customer',
                      textAlign:
                          TextAlign.center,
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight:
                            FontWeight.w600,
                        color:
                            const Color(
                          0xFF101B5C,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}