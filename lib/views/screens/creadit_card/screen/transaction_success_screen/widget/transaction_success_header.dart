import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/custom_text.dart';
import 'package:lekra/services/theme.dart';

class TransactionSuccessHeader extends StatelessWidget {
  const TransactionSuccessHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        sizedBoxHeight(height: 34),
        Container(
          width: 124.w,
          height: 124.h,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFFE8F7EF),
          ),
          child: Center(
            child: Container(
              width: 96.w,
              height: 96.h,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF20B978),
              ),
              child: Icon(
                Icons.check_rounded,
                size: 58.sp,
                color: white,
              ),
            ),
          ),
        ),
        sizedBoxHeight(height: 28),
        CustomText(
          'Transaction Successful!',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: 26.sp,
                fontWeight: FontWeight.w700,
                color: textPrimary,
              ),
        ),
        sizedBoxHeight(height: 10),
        CustomText(
          'Your money withdrawal request has\n'
          'been placed successfully.',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 16.sp,
                height: 1.5,
                color: textSecondary,
              ),
        ),
      ],
    );
  }
}
