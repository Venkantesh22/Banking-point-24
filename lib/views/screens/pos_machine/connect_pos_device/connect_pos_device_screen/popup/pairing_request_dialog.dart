import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/custom_text.dart';
import 'package:lekra/services/theme.dart';
import 'package:lekra/views/screens/pos_machine/connect_pos_device/connect_pos_device_screen/popup/pairing_device_info.dart';


class PairingRequestDialog extends StatelessWidget {
  const PairingRequestDialog({
    super.key,
  });

  // Demo values
  static const String deviceName = 'TPIPAY POS 1234';
  static const String deviceAddress = '00:1A:7D:DA:7D:13';

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(
        horizontal: 24.w,
      ),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(
          22.w,
          24.h,
          22.w,
          20.h,
        ),
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(
            color: greyBorder,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 30,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _PairingIcon(),

            sizedBoxHeight(height: 18),

            CustomText(
              'Pair with POS Device?',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: textPrimary,
                  ),
            ),

            sizedBoxHeight(height: 8),

            CustomText(
              'A Bluetooth pairing request was received',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: 12.sp,
                    color: textSecondary,
                  ),
            ),

            sizedBoxHeight(height: 20),

            const PairingDeviceInfo(
              deviceName: deviceName,
              deviceAddress: deviceAddress,
            ),

            sizedBoxHeight(height: 20),

            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: primaryColorLight,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.info_outline_rounded,
                    size: 19.sp,
                    color: primaryColor,
                  ),

                  sizedBoxWidth(width: 8),

                  Expanded(
                    child: CustomText(
                      'Make sure you are pairing with your '
                      'authorized TPIPAY POS machine.',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(
                            fontSize: 11.sp,
                            height: 1.45,
                            color: textPrimary,
                          ),
                    ),
                  ),
                ],
              ),
            ),

            sizedBoxHeight(height: 22),

            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 48.h,
                    child: OutlinedButton(
                      onPressed: () {
                        pop(context);
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                          color: greyBorder,
                          width: 1.2,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: CustomText(
                        'Cancel',
                        style:
                            Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: textSecondary,
                                ),
                      ),
                    ),
                  ),
                ),

                sizedBoxWidth(width: 12),

                Expanded(
                  child: SizedBox(
                    height: 48.h,
                    child: ElevatedButton(
                      onPressed: () {
                        debugPrint(
                          'Pairing with $deviceName',
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: primaryColor,
                        foregroundColor: white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: CustomText(
                        'Pair',
                        style:
                            Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w700,
                                  color: white,
                                ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _PairingIcon extends StatelessWidget {
  const _PairingIcon();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 72.w,
      height: 72.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: primaryColorLight,
      ),
      child: Center(
        child: Container(
          width: 52.w,
          height: 52.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: primaryColor,
            boxShadow: [
              BoxShadow(
                color: primaryColor.withValues(alpha: 0.25),
                blurRadius: 12,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Icon(
            Icons.bluetooth_rounded,
            size: 28.sp,
            color: white,
          ),
        ),
      ),
    );
  }
}