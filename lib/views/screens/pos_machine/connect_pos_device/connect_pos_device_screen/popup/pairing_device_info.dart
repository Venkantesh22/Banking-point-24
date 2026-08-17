import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lekra/generated/assets.dart';
import 'package:lekra/services/custom_text.dart';
import 'package:lekra/services/theme.dart';

class PairingDeviceInfo extends StatelessWidget {
  const PairingDeviceInfo({
    super.key,
    required this.deviceName,
    required this.deviceAddress,
  });

  final String deviceName;
  final String deviceAddress;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: greyBorder,
        ),
      ),
      child: Row(
        children: [
          Container(
              width: 50.w,
              height: 50.h,
              padding: EdgeInsets.all(10.r),
              decoration: BoxDecoration(
                color: primaryColorLight,
                borderRadius: BorderRadius.circular(14.r),
              ),
              child: SvgPicture.asset(
                Assets.svgsPosMachine,
                fit: BoxFit.contain,
                colorFilter: ColorFilter.mode(primaryColor, BlendMode.srcIn),
              )

              // Icon(
              //   Icons.point_of_sale_rounded,
              //   size: 26.sp,
              //   color: primaryColor,
              // ),
              ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  deviceName,
                  maxLines: 1,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: textPrimary,
                      ),
                ),
                SizedBox(height: 5.h),
                CustomText(
                  deviceAddress,
                  maxLines: 1,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 11.sp,
                        color: textSecondary,
                      ),
                ),
                SizedBox(height: 7.h),
                Row(
                  children: [
                    Container(
                      width: 7.w,
                      height: 7.h,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFF20A865),
                      ),
                    ),
                    SizedBox(width: 5.w),
                    CustomText(
                      'Ready to pair',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF20A865),
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Icon(
            Icons.bluetooth_connected_rounded,
            size: 21.sp,
            color: primaryColor,
          ),
        ],
      ),
    );
  }
}
