import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lekra/controllers/card_money_controller/custom_kyc_controller.dart';
import 'package:lekra/services/custom_text.dart';
import 'package:lekra/services/theme.dart';
import 'package:lekra/views/base/common_button.dart';
import 'package:lekra/views/base/custom_image.dart';

class CheckCustomerKycScreen extends StatelessWidget {
  const CheckCustomerKycScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CustomKycController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: white,
          appBar: AppBar(
            backgroundColor: white,
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 20.r,
                color: const Color(0xFF101B5C),
              ),
            ),
            title: CustomText(
              'Check Customer KYC',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF101B5C),
              ),
            ),
            centerTitle: true,
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
                vertical: 10.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  Center(
                    child: CustomImage(
                      path: Assets.imagesSearchInMobile,
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                  ),


                  Center(
                    child: CustomText(
                      'Enter Customer Mobile Number',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF101B5C),
                      ),
                    ),
                  ),

                  SizedBox(height: 8.h),

                  Center(
                    child: CustomText(
                      'We will check if this customer is registered\n'
                      'and KYC is completed.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14.sp,
                        height: 1.6,
                        color: greyDark,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),

                  SizedBox(height: 28.h),

                  // ==================================================
                  // MOBILE LABEL
                  // ==================================================

                  CustomText(
                    'Mobile Number',
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF101B5C),
                    ),
                  ),

                  SizedBox(height: 8.h),

                  // ==================================================
                  // MOBILE FIELD
                  // ==================================================

                  Container(
                    height: 54.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: controller.mobileError != null
                            ? Colors.red
                            : const Color(0xFFD6DCE8),
                      ),
                    ),
                    child: Row(
                      children: [
                        // Country code
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                          ),
                          child: CustomText(
                            '+91',
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF101B5C),
                            ),
                          ),
                        ),

                        Container(
                          width: 1,
                          height: 28.h,
                          color: const Color(0xFFD6DCE8),
                        ),

                        // Mobile number
                        Expanded(
                          child: TextField(
                            controller: controller.mobileNumberController,
                            keyboardType: TextInputType.phone,
                            textInputAction: TextInputAction.done,
                            maxLength: 10,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(
                                10,
                              ),
                            ],
                            onChanged: (_) {
                              if (controller.mobileError != null) {
                                controller.mobileError = null;
                                controller.update();
                              }
                            },
                            decoration: InputDecoration(
                              counterText: '',
                              border: InputBorder.none,
                              hintText: 'Enter mobile number',
                              hintStyle: TextStyle(
                                fontSize: 14.sp,
                                color: const Color(0xFF9AA4BA),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 14.w,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // ==================================================
                  // ERROR
                  // ==================================================

                  if (controller.mobileError != null) ...[
                    SizedBox(height: 6.h),
                    CustomText(
                      controller.mobileError!,
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: Colors.red,
                      ),
                    ),
                  ],

                  SizedBox(height: 18.h),

                  // ==================================================
                  // INFO CARD
                  // ==================================================

                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(14.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F6FF),
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: const Color(0xFFD5E3FF),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 32.w,
                          height: 32.w,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.info_outline_rounded,
                            color: white,
                            size: 19.r,
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: CustomText(
                            'We will check this number in our '
                            'system and return the customer KYC status.',
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              fontSize: 12.sp,
                              height: 1.5,
                              color: const Color(0xFF27366F),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 26.h),

                  // ==================================================
                  // WHAT HAPPENS NEXT
                  // ==================================================

                  CustomText(
                    'What happens next?',
                    style: TextStyle(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF101B5C),
                    ),
                  ),

                  SizedBox(height: 14.h),

                  _StatusInfoRow(
                    icon: Icons.check_rounded,
                    iconColor: const Color(0xFF16B66A),
                    title: 'If KYC is already completed',
                    description: 'You will be directed to withdraw money.',
                  ),

                  Padding(
                    padding: EdgeInsets.only(
                      left: 22.w,
                    ),
                    child: Divider(
                      height: 22.h,
                      color: const Color(0xFFE5E9F2),
                    ),
                  ),

                  _StatusInfoRow(
                    icon: Icons.person_outline_rounded,
                    iconColor: const Color(0xFFF59E0B),
                    title: 'If KYC is not completed',
                    description:
                        'You will be directed to complete customer KYC.',
                  ),

                  SizedBox(height: 28.h),

                  // ==================================================
                  // CHECK BUTTON
                  // ==================================================

                  CustomButton(
                    title: controller.isCheckingKyc
                        ? 'Checking...'
                        : 'Check Customer KYC',
                    height: 52.h,
                    radius: 12.r,
                    gradient: LinearGradient(
                      colors: [
                        primaryColor,
                        const Color(0xFF1747B8),
                      ],
                    ),
                    onTap: controller.isCheckingKyc
                        ? null
                        : () async {
                            final bool? isKycCompleted =
                                await controller.checkCustomerKyc();

                            if (!context.mounted || isKycCompleted == null) {
                              return;
                            }

                            if (isKycCompleted) {
                              // navigate(
                              //   context: context,
                              //   page:
                              //       const WithdrawMoneyScreen(),
                              // );
                            } else {
                              // navigate(
                              //   context: context,
                              //   page:
                              //       const CustomerKycScreen(),
                              // );
                            }
                          },
                  ),

                  SizedBox(height: 18.h),

                  // ==================================================
                  // SECURITY
                  // ==================================================

                  Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.lock_outline_rounded,
                          size: 16.r,
                          color: greyDark,
                        ),
                        SizedBox(width: 6.w),
                        CustomText(
                          'Your information is secure and protected',
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: greyDark,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// ================================================================
// STATUS INFORMATION ROW
// ================================================================

class _StatusInfoRow extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String description;

  const _StatusInfoRow({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 44.w,
          height: 44.w,
          decoration: BoxDecoration(
            color: iconColor.withValues(alpha: 0.12),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: iconColor,
            size: 24.r,
          ),
        ),
        SizedBox(width: 14.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                title,
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF101B5C),
                ),
              ),
              SizedBox(height: 4.h),
              CustomText(
                description,
                style: TextStyle(
                  fontSize: 12.sp,
                  height: 1.4,
                  color: greyDark,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
