import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/custom_text.dart';
import 'package:lekra/services/theme.dart';

class TransactionDetailsCard extends StatelessWidget {
  const TransactionDetailsCard({
    super.key,
  });

  // Demo data
  static const String amount = '₹25,000.00';
  static const String processingFee = '₹0.00';
  static const String gst = '₹0.00';
  static const String totalDebit = '₹25,000.00';

  static const String bankName = 'HDFC Bank';
  static const String accountNumber = 'XXXX XXXX 4567';
  static const String transactionId = 'TXN51234567890';
  static const String dateTime = '12 May 2025 • 11:45 AM';
  static const String status = 'Successful';

  @override
  Widget build(BuildContext context) {
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
          const TransactionDetailRow(
            label: 'Amount',
            value: amount,
          ),
          const TransactionDetailRow(
            label: 'Processing Fee',
            value: processingFee,
          ),
          const TransactionDetailRow(
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
          TransactionDetailRow(
            label: 'Total Debit',
            value: totalDebit,
            valueColor: red,
            valueFontWeight: FontWeight.w700,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: Divider(
              color: greyBorder,
              height: 1,
            ),
          ),
          const TransactionDetailRow(
            label: 'To',
            value: bankName,
          ),
          const TransactionDetailRow(
            label: 'A/c No.',
            value: accountNumber,
          ),
          const TransactionDetailRow(
            label: 'Transaction ID',
            value: transactionId,
          ),
          const TransactionDetailRow(
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
                    color: const Color(0xFFE7F8EF),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: CustomText(
                    status,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF20A865),
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

class TransactionDetailRow extends StatelessWidget {
  const TransactionDetailRow({
    super.key,
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
          Expanded(
            child: CustomText(
              value,
              textAlign: TextAlign.end,
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
