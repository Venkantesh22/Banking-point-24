import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/custom_text.dart';
import 'package:lekra/services/theme.dart';
import 'package:lekra/views/screens/pos_machine/connect_pos_device/connect_pos_device_screen/widget/available_pos_devices.dart';
import 'package:lekra/views/screens/pos_machine/connect_pos_device/connect_pos_device_screen/widget/pos_search_indicator.dart';
import 'package:lekra/views/screens/pos_machine/connect_pos_device/connect_pos_device_screen/widget/scan_again_button.dart';

class ConnectPosDeviceScreen extends StatelessWidget {
  const ConnectPosDeviceScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 3,
        centerTitle: true,
        title: CustomText(
          'Connect to POS Device',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: 19.sp,
                fontWeight: FontWeight.w700,
                color: textPrimary,
              ),
        ),
      ),
      backgroundColor: backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            // const PosSearchHeader(),

            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: AppConstants.screenPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const PosSearchIndicator(),
                    sizedBoxHeight(height: 28),
                    const AvailablePosDevices(),
                    sizedBoxHeight(height: 24),
                    ScanAgainButton(
                      onTap: () {
                        debugPrint('Scan Again');
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
