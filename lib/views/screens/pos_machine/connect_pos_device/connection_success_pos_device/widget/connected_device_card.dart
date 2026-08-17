import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/custom_text.dart';
import 'package:lekra/services/theme.dart';

class ConnectedDeviceCard extends StatelessWidget {
  const ConnectedDeviceCard({
    super.key,
  });

  // Demo values
  static const String deviceName = 'TPIPAY POS 1234';
  static const String deviceAddress = '00:1A:7D:DA:7D:13';

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
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 62.w,
            height: 62.h,
            decoration: BoxDecoration(
              color: primaryColorLight,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Icon(
              Icons.point_of_sale_rounded,
              size: 32.sp,
              color: primaryColor,
            ),
          ),

          sizedBoxWidth(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  deviceName,
                  maxLines: 1,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: textPrimary,
                      ),
                ),

                sizedBoxHeight(height: 6),

                CustomText(
                  deviceAddress,
                  maxLines: 1,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 11.sp,
                        color: textSecondary,
                      ),
                ),

                sizedBoxHeight(height: 8),

                Row(
                  children: [
                    Container(
                      width: 8.w,
                      height: 8.h,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFF20B978),
                      ),
                    ),

                    sizedBoxWidth(width: 6),

                    CustomText(
                      'Connected',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontSize: 11.sp,
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
            size: 24.sp,
            color: primaryColor,
          ),
        ],
      ),
    );
  }
}