import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/custom_text.dart';
import 'package:lekra/services/theme.dart';

import '../payment_result_screen.dart';

class PaymentResultDetails extends StatelessWidget {
  const PaymentResultDetails({
    super.key,
    required this.status,
  });

  final PaymentStatus status;

  static const String amount = '₹25,000.00';
  static const String processingFee = '₹0.00';
  static const String gst = '₹0.00';
  static const String totalDebit = '₹25,000.00';

  static const String customerName = 'Rahul Kumar';
  static const String upiId = 'rahul.kumar@okhdfcbank';
  static const String bankName = 'HDFC Bank';

  static const String transactionId = 'TXN51234567890';
  static const String dateTime = '17 Aug 2026 • 02:15 PM';

  @override
  Widget build(BuildContext context) {
    late final String statusText;
    late final Color statusColor;
    late final Color statusBackground;

    switch (status) {
      case PaymentStatus.successful:
        statusText = 'Successful';
        statusColor = const Color(0xFF20A865);
        statusBackground = const Color(0xFFE7F8EF);
        break;

      case PaymentStatus.pending:
        statusText = 'Pending';
        statusColor = const Color(0xFFF59E0B);
        statusBackground = const Color(0xFFFFF7E6);
        break;

      case PaymentStatus.cancelled:
        statusText = 'Cancelled';
        statusColor = red;
        statusBackground = redLight;
        break;
    }

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        18.w,
        18.h,
        18.w,
        8.h,
      ),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: greyBorder,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 14,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          _DetailRow(
            label: 'Amount',
            value: amount,
          ),

          _DetailRow(
            label: 'Processing Fee',
            value: processingFee,
          ),

          _DetailRow(
            label: 'GST',
            value: gst,
          ),

          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: Divider(
              color: greyBorder,
              height: 1,
            ),
          ),

          _DetailRow(
            label: 'Total Debit',
            value: totalDebit,
            valueColor: status == PaymentStatus.cancelled
                ? red
                : textPrimary,
            valueFontWeight: FontWeight.w700,
          ),

          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: Divider(
              color: greyBorder,
              height: 1,
            ),
          ),

          _DetailRow(
            label: 'Customer',
            value: customerName,
          ),

          _DetailRow(
            label: 'UPI ID',
            value: upiId,
          ),

          _DetailRow(
            label: 'Bank',
            value: bankName,
          ),

          _DetailRow(
            label: 'Transaction ID',
            value: transactionId,
          ),

          _DetailRow(
            label: 'Date & Time',
            value: dateTime,
          ),

          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: Row(
              children: [
                Expanded(
                  child: CustomText(
                    'Status',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 13.sp,
                          color: textSecondary,
                        ),
                  ),
                ),

                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: statusBackground,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: CustomText(
                    statusText,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: statusColor,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.label,
    required this.value,
    this.valueColor,
    this.valueFontWeight = FontWeight.w500,
  });

  final String label;
  final String value;
  final Color? valueColor;
  final FontWeight valueFontWeight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 7.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: CustomText(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 13.sp,
                    color: textSecondary,
                  ),
            ),
          ),

          sizedBoxWidth(width: 12),

          Flexible(
            child: CustomText(
              value,
              textAlign: TextAlign.right,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 13.sp,
                    fontWeight: valueFontWeight,
                    color: valueColor ?? textPrimary,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}