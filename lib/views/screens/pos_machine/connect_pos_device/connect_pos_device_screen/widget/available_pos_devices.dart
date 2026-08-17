import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/custom_text.dart';
import 'package:lekra/services/theme.dart';
import 'package:lekra/views/base/custom_image.dart';
import 'package:lekra/views/screens/pos_machine/connect_pos_device/connect_pos_device_screen/popup/pairing_request_dialog.dart';

class AvailablePosDevices extends StatelessWidget {
  const AvailablePosDevices({
    super.key,
  });

  static const List<PosDeviceDemo> devices = [
    PosDeviceDemo(
      name: 'TPIPAY POS 1234',
      address: '00:1A:7D:DA:7D:13',
      signal: '-60 dBm',
      isRecommended: true,
    ),
    PosDeviceDemo(
      name: 'TPIPAY POS 5678',
      address: '00:1A:7D:DA:7D:14',
      signal: '-65 dBm',
    ),
    PosDeviceDemo(
      name: 'Other Device',
      address: '00:1A:7D:DA:7D:15',
      signal: '-70 dBm',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          'Available Devices',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: textPrimary,
              ),
        ),
        sizedBoxHeight(height: 12),
        ...devices.map(
          (device) => Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: PosDeviceCard(
              device: device,
              onTap: () {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) {
                    return const PairingRequestDialog();
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class PosDeviceDemo {
  const PosDeviceDemo({
    required this.name,
    required this.address,
    required this.signal,
    this.isRecommended = false,
  });

  final String name;
  final String address;
  final String signal;
  final bool isRecommended;
}

class PosDeviceCard extends StatelessWidget {
  const PosDeviceCard({
    super.key,
    required this.device,
    required this.onTap,
  });

  final PosDeviceDemo device;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.r),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(14.w),
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: device.isRecommended ? primaryColor : greyBorder,
              width: device.isRecommended ? 1.3 : 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                  width: 48.w,
                  height: 48.h,
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: primaryColorLight,
                  ),
                  child: SvgPicture.asset(
                    Assets.svgsPosMachine,

                    fit: BoxFit.contain,
                    colorFilter:
                        ColorFilter.mode(primaryColor, BlendMode.srcIn),
                  )
                  
                  ),
              sizedBoxWidth(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: CustomText(
                            device.name,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w700,
                                  color: textPrimary,
                                ),
                          ),
                        ),
                        if (device.isRecommended) ...[
                          sizedBoxWidth(width: 6),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 7.w,
                              vertical: 3.h,
                            ),
                            decoration: BoxDecoration(
                              color: primaryColorLight,
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: CustomText(
                              'Recommended',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    fontSize: 8.sp,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    sizedBoxHeight(height: 5),
                    CustomText(
                      device.address,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontSize: 11.sp,
                            color: greyText2,
                          ),
                    ),
                  ],
                ),
              ),
              sizedBoxWidth(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Icon(
                    Icons.bluetooth_connected_rounded,
                    size: 20.sp,
                    color: primaryColor,
                  ),
                  sizedBoxHeight(height: 4),
                  CustomText(
                    device.signal,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize: 10.sp,
                          color: greyText2,
                        ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
