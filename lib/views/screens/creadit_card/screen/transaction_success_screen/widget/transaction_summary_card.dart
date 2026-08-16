import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/custom_text.dart';
import 'package:lekra/services/theme.dart';


class TransactionSummaryCard extends StatelessWidget {
  const TransactionSummaryCard({
    super.key,
  });

  // Demo transaction values
  static const double amount = 25000.00;
  static const double processingFee = 0.00;
  static const double gst = 0.00;

  static const String bankName = 'HDFC Bank';
  static const String accountNumber = 'XXXX XXXX 4567';
  static const String transactionId = 'TXN51234567890';
  static const String dateTime = '12 May 2025 • 11:45 AM';

  static const String status = 'Successful';

  static const double totalDebit =
      amount + processingFee + gst;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        20.w,
        18.h,
        20.w,
        8.h,
      ),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(22.r),
        border: Border.all(
          color: greyBorder,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          _TransactionRow(
            label: 'Amount',
            value: PriceConverter.convertToNumberFormat(amount),
          ),

          _TransactionRow(
            label: 'Processing Fee',
            value: PriceConverter.convertToNumberFormat(
              processingFee,
            ),
          ),

          _TransactionRow(
            label: 'GST',
            value: PriceConverter.convertToNumberFormat(gst),
          ),

          Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h),
            child: Divider(
              color: greyBorder,
              height: 1,
            ),
          ),

          _TransactionRow(
            label: 'Total Debit',
            value: PriceConverter.convertToNumberFormat(
              totalDebit,
            ),
            valueColor: red,
            valueFontWeight: FontWeight.w700,
          ),

          Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h),
            child: Divider(
              color: greyBorder,
              height: 1,
            ),
          ),

          _TransactionRow(
            label: 'To',
            value: bankName,
          ),

          _TransactionRow(
            label: 'A/c No.',
            value: accountNumber,
          ),

          _TransactionRow(
            label: 'Transaction ID',
            value: transactionId,
          ),

          _TransactionRow(
            label: 'Date & Time',
            value: dateTime,
          ),

          Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h),
            child: Row(
              children: [
                Expanded(
                  child: CustomText(
                    'Status',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 14.sp,
                          color: textSecondary,
                        ),
                  ),
                ),

                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 14.w,
                    vertical: 7.h,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F7EF),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: CustomText(
                    status,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize: 13.sp,
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

class _TransactionRow extends StatelessWidget {
  const _TransactionRow({
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
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: CustomText(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 14.sp,
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
                    fontSize: 14.sp,
                    color: valueColor ?? textPrimary,
                    fontWeight: valueFontWeight,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}