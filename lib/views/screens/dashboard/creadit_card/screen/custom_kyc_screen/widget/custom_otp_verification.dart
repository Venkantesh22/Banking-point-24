import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lekra/controllers/card_money_controller/custom_kyc_controller.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/custom_text.dart';
import 'package:lekra/services/input_decoration.dart';
import 'package:lekra/services/theme.dart';

class CustomerOtpVerificationSection extends StatelessWidget {
  const CustomerOtpVerificationSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CustomKycController>(builder: (customKycController) {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: customKycController.isOtpVerified
                ? Colors.green
                : primaryColor.withValues(
                    alpha: 0.25,
                  ),
          ),
          color: customKycController.isOtpVerified
              ? Colors.green.withValues(
                  alpha: 0.03,
                )
              : Colors.transparent,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              'Enter OTP',
              style: Helper(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: black,
                  ),
            ),
            sizedBoxHeight(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                6,
                (index) {
                  return SizedBox(
                    width: 40.w,
                    height: 46.h,
                    child: TextFormField(
                      controller: customKycController.otpControllers[index],
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      textAlign: TextAlign.center,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      onChanged: (value) {
                        customKycController.updateOtp();

                        if (value.isNotEmpty && index < 5) {
                          FocusScope.of(context).nextFocus();
                        }

                        if (customKycController.otp.length == 6) {
                          customKycController.verifyOtp();
                        }
                      },
                      decoration: CustomDecoration.inputDecoration(
                        borderRadius: 8,
                        suffix: null,
                        icon: null,
                        prefixText: null,
                        prefixStyle: null,
                        bgColor: Colors.white,
                        hint: '',
                        hintStyle: TextStyle(
                          fontSize: 12.sp,
                        ),
                        borderColor: customKycController.isOtpVerified
                            ? Colors.green
                            : grey.withValues(
                                alpha: 0.4,
                              ),
                        borderWidth: 0.5,
                      ),
                    ),
                  );
                },
              ),
            ),
            sizedBoxHeight(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  'Resend OTP in ',
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: greyDark,
                  ),
                ),
                CustomText(
                  '00:28',
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
            if (customKycController.isOtpVerified) ...[
              sizedBoxHeight(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 16.r,
                  ),
                  sizedBoxWidth(width: 5),
                  CustomText(
                    'OTP Verified',
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: Colors.green,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      );
    });
  }
}
