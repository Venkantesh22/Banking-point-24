import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/custom_text.dart';
import 'package:lekra/services/theme.dart';

class ConnectionSuccessHeader extends StatelessWidget {
  const ConnectionSuccessHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        sizedBoxHeight(height: 28),
        Container(
          width: 112.w,
          height: 112.h,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFFE8F7EF),
          ),
          child: Center(
            child: Container(
              width: 82.w,
              height: 82.h,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF20B978),
              ),
              child: Icon(
                Icons.check_rounded,
                size: 48.sp,
                color: white,
              ),
            ),
          ),
        ),
        sizedBoxHeight(height: 22),
        CustomText(
          'Connected Successfully',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: 23.sp,
                fontWeight: FontWeight.w700,
                color: textPrimary,
              ),
        ),
        sizedBoxHeight(height: 8),
        CustomText(
          'Your POS device is connected and ready\nto process transactions.',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 13.sp,
                height: 1.5,
                color: textSecondary,
              ),
        ),
      ],
    );
  }
}
