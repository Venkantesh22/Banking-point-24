import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/custom_text.dart';
import 'package:lekra/services/theme.dart';

class DeviceStatusCard extends StatelessWidget {
  const DeviceStatusCard({
    super.key,
  });

  // Demo values
  static const int battery = 85;
  static const String signalStrength = 'Strong';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: greyBorder,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.035),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          _StatusRow(
            icon: Icons.battery_5_bar_rounded,
            iconColor: const Color(0xFF20A865),
            title: 'Battery',
            value: '$battery%',
          ),

          Padding(
            padding: EdgeInsets.symmetric(vertical: 14.h),
            child: Divider(
              color: greyBorder,
              height: 1,
            ),
          ),

          _StatusRow(
            icon: Icons.signal_cellular_alt_rounded,
            iconColor: primaryColor,
            title: 'Signal Strength',
            value: signalStrength,
          ),
        ],
      ),
    );
  }
}

class _StatusRow extends StatelessWidget {
  const _StatusRow({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 42.w,
          height: 42.h,
          decoration: BoxDecoration(
            color: iconColor.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Icon(
            icon,
            size: 23.sp,
            color: iconColor,
          ),
        ),

        sizedBoxWidth(width: 12),

        Expanded(
          child: CustomText(
            title,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 14.sp,
                  color: textSecondary,
                ),
          ),
        ),

        CustomText(
          value,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
                color: value == 'Strong'
                    ? const Color(0xFF20A865)
                    : textPrimary,
              ),
        ),
      ],
    );
  }
}