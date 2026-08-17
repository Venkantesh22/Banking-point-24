import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/custom_text.dart';
import 'package:lekra/services/theme.dart';


class PosSearchIndicator extends StatelessWidget {
  const PosSearchIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        sizedBoxHeight(height: 12),

        Center(
          child: SizedBox(
            width: 190.w,
            height: 190.h,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 175.w,
                  height: 175.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: primaryColor.withValues(alpha: 0.04),
                  ),
                ),

                Container(
                  width: 140.w,
                  height: 140.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: primaryColor.withValues(alpha: 0.08),
                  ),
                ),

                Container(
                  width: 105.w,
                  height: 105.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: primaryColor.withValues(alpha: 0.13),
                  ),
                ),

                Container(
                  width: 72.w,
                  height: 72.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        primaryColor,
                        thiryaryColor,
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: primaryColor.withValues(alpha: 0.25),
                        blurRadius: 18,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.bluetooth_rounded,
                    size: 38.sp,
                    color: white,
                  ),
                ),
              ],
            ),
          ),
        ),

        sizedBoxHeight(height: 18),

        CustomText(
          'Searching for nearby devices...',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
                color: textPrimary,
              ),
        ),

        sizedBoxHeight(height: 8),

        CustomText(
          'Make sure your POS machine is turned on\n'
          'and Bluetooth is enabled.',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontSize: 12.sp,
                height: 1.5,
                color: textSecondary,
              ),
        ),
      ],
    );
  }
}