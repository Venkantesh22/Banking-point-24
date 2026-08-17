import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/custom_text.dart';
import 'package:lekra/services/theme.dart';
import 'package:lekra/views/base/common_button.dart';
import 'package:lekra/views/screens/pos_machine/connect_pos_device/connect_pos_device_screen/connect_pos_device_screen.dart';
import 'package:lekra/views/screens/pos_machine/connect_pos_device/connection_success_pos_device/widget/connected_device_card.dart';
import 'package:lekra/views/screens/pos_machine/connect_pos_device/connection_success_pos_device/widget/connection_success_header.dart';
import 'package:lekra/views/screens/pos_machine/connect_pos_device/connection_success_pos_device/widget/device_status_card.dart';

class ConnectionSuccessPosDeviceScreen extends StatelessWidget {
  const ConnectionSuccessPosDeviceScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        // elevation: 3,
      ),
      backgroundColor: backgroundLight,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: AppConstants.screenPadding,
          child: Column(
            children: [
              const ConnectionSuccessHeader(),
              sizedBoxHeight(height: 30),
              const ConnectedDeviceCard(),
              sizedBoxHeight(height: 20),
              const DeviceStatusCard(),
              sizedBoxHeight(height: 60),
              CustomButton(
                onTap: () {
                  navigate(
                      context: context,
                      isReplace: true,
                      page: ConnectPosDeviceScreen());
                },
                type: ButtonType.secondary,
                borderColor: red,
                borderWidth: 1.2,
                radius: 12.r,
                fontSize: 14.sp,
                color: white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.bluetooth_disabled_rounded,
                      size: 20.sp,
                      color: red,
                    ),
                    SizedBox(width: 8.w),
                    CustomText(
                      'Disconnect',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: red,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
