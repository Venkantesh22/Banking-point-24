// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lekra/controllers/card_money_controller/custom_kyc_controller.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/custom_text.dart';
import 'package:lekra/services/theme.dart';
import 'package:lekra/views/base/common_button.dart';
import 'package:lekra/views/screens/dashboard/creadit_card/screen/custom_kyc_screen/widget/custom_otp_verification.dart';
import 'package:lekra/views/screens/dashboard/creadit_card/screen/custom_kyc_screen/widget/upload_verification_widget.dart';
import 'package:lekra/views/screens/dashboard/creadit_card/widget/section_title.dart';
import 'package:lekra/views/screens/widget/text_box/app_text_box.dart';

class CustomKycScreen extends StatelessWidget {
  CustomKycScreen({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CustomKycController>(
      builder: (controller) {
        return Scaffold(
          body: SafeArea(
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                padding: AppConstants.screenPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ==================================================
                    // HEADER
                    // ==================================================

                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back,
                            color: primaryColor,
                            size: 24.r,
                          ),
                        ),
                        sizedBoxWidth(width: 12),
                        Expanded(
                          child: CustomText(
                            'Customer KYC',
                            style:
                                Helper(context).textTheme.bodyMedium?.copyWith(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w700,
                                      color: black,
                                    ),
                          ),
                        ),
                      ],
                    ),

                    sizedBoxHeight(height: 4),

                    Padding(
                      padding: EdgeInsets.only(left: 36.w),
                      child: CustomText(
                        'Complete customer KYC to withdraw money',
                        style: Helper(context).textTheme.bodySmall?.copyWith(
                              fontSize: 11.sp,
                              color: greyDark,
                            ),
                      ),
                    ),

                    sizedBoxHeight(height: 24),

                    // ==================================================
                    // PERSONAL INFORMATION
                    // ==================================================

                    SectionTitle(
                      title: 'Personal Information',
                    ),

                    sizedBoxHeight(height: 12),

                    // --------------------------------------------------
                    // FULL NAME
                    // --------------------------------------------------

                    AppTextFieldWithHeading(
                      controller: controller.fullNameController,
                      heading: 'Full Name (as per PAN/Aadhaar)',
                      hindText: 'Enter full name',
                      isRequired: true,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter full name';
                        }

                        if (value.trim().length < 3) {
                          return 'Please enter a valid full name';
                        }

                        return null;
                      },
                    ),

                    sizedBoxHeight(height: 16),

                    // --------------------------------------------------
                    // MOBILE NUMBER
                    // --------------------------------------------------

                    AppTextFieldWithHeading(
                      controller: controller.mobileNumberController,
                      heading: 'Mobile Number',
                      hindText: 'Enter mobile number',
                      prefixText: '+91 ',
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.next,
                      maxLength: 10,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      isRequired: true,
                      readOnly: controller.isMobileVerified,
                      suffix: controller.isMobileVerified
                          ? Icon(
                              Icons.check_circle,
                              color: Colors.green,
                              size: 20.r,
                            )
                          : TextButton(
                              onPressed: () {
                                formKey.currentState?.validate();

                                final String mobile = controller
                                    .mobileNumberController.text
                                    .trim();

                                if (RegExp(
                                  r'^[6-9][0-9]{9}$',
                                ).hasMatch(mobile)) {
                                  controller.setMobileVerified(
                                    true,
                                  );
                                }
                              },
                              child: CustomText(
                                'Verify',
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter mobile number';
                        }

                        if (!RegExp(
                          r'^[6-9][0-9]{9}$',
                        ).hasMatch(value.trim())) {
                          return 'Please enter a valid 10 digit mobile number';
                        }

                        return null;
                      },
                    ),

                    sizedBoxHeight(height: 16),

                    // ==================================================
                    // OTP
                    // ==================================================

                    SectionTitle(
                      title: 'OTP Verification',
                    ),

                    sizedBoxHeight(height: 8),

                    CustomerOtpVerificationSection(),

                    sizedBoxHeight(height: 16),

                    // ==================================================
                    // EMAIL
                    // ==================================================

                    AppTextFieldWithHeading(
                      controller: controller.emailController,
                      heading: 'Email (Optional)',
                      hindText: 'Enter email address',
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return null;
                        }

                        final email = value.trim();

                        if (!RegExp(
                          r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
                        ).hasMatch(email)) {
                          return 'Please enter a valid email address';
                        }

                        return null;
                      },
                    ),

                    sizedBoxHeight(height: 22),

                    // ==================================================
                    // PAN VERIFICATION
                    // ==================================================

                    SectionTitle(
                      title: 'PAN Verification',
                    ),

                    sizedBoxHeight(height: 4),

                    CustomText(
                      'Upload clear image of your PAN card',
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: greyDark,
                      ),
                    ),

                    sizedBoxHeight(height: 10),

                    UploadCardWidget(
                      title: controller.panCardImage == null
                          ? 'Upload PAN Card'
                          : 'PAN Card Uploaded',
                      subtitle: 'JPG, PNG up to 5MB',
                      icon: Icons.credit_card_outlined,
                      uploaded: controller.panCardImage != null,
                      file: controller.panCardImage,
                      onTap: () {
                        controller.pickPanCardImage(context);
                      },
                      onRemove: controller.removePanCardImage,
                    ),

                    sizedBoxHeight(height: 20),

                    // ==================================================
                    // AADHAAR VERIFICATION
                    // ==================================================

                    SectionTitle(
                      title: 'Aadhaar Verification',
                    ),

                    sizedBoxHeight(height: 10),

                    Row(
                      children: [
                        Expanded(
                          child: UploadCardWidget(
                            title: controller.aadhaarFrontImage == null
                                ? 'Aadhaar Front'
                                : 'Uploaded',
                            subtitle: 'Upload front side',
                            icon: Icons.badge_outlined,
                            uploaded: controller.aadhaarFrontImage != null,
                            file: controller.aadhaarFrontImage,
                            onTap: () {
                              controller.pickAadhaarFrontImage(context);
                            },
                            onRemove: controller.removeAadhaarFrontImage,
                          ),
                        ),
                        sizedBoxWidth(width: 10),
                        Expanded(
                          child: UploadCardWidget(
                            title: controller.aadhaarBackImage == null
                                ? 'Aadhaar Back'
                                : 'Uploaded',
                            subtitle: 'Upload back side',
                            icon: Icons.badge_outlined,
                            uploaded: controller.aadhaarBackImage != null,
                            file: controller.aadhaarBackImage,
                            onTap: () {
                              controller.pickAadhaarBackImage(context);
                            },
                            onRemove: controller.removeAadhaarBackImage,
                          ),
                        ),
                      ],
                    ),

                    sizedBoxHeight(height: 20),

                    // ==================================================
                    // LIVE PHOTO
                    // ==================================================

                    SectionTitle(
                      title: 'Live Photo',
                    ),

                    sizedBoxHeight(height: 4),

                    CustomText(
                      'Capture your live photo for verification',
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: greyDark,
                      ),
                    ),

                    sizedBoxHeight(height: 10),

                    UploadCardWidget(
                      title: controller.livePhoto == null
                          ? 'Capture Live Photo'
                          : 'Live Photo Captured',
                      subtitle: 'Use camera',
                      icon: Icons.camera_alt_outlined,
                      uploaded: controller.livePhoto != null,
                      file: controller.livePhoto,
                      onTap: () {
                        controller.captureLivePhoto(context);
                      },
                      onRemove: controller.removeLivePhoto,
                    ),

                    sizedBoxHeight(height: 24),

                    // ==================================================
                    // SUBMIT
                    // ==================================================

                    CustomButton(
                      title: controller.isSubmitting
                          ? 'Submitting...'
                          : 'Submit KYC',
                      height: 48.h,
                      radius: 8.r,
                      gradient: LinearGradient(
                        colors: [
                          primaryColor,
                          secondaryColor,
                        ],
                      ),
                      onTap: controller.isSubmitting
                          ? null
                          : () {
                              final bool valid =
                                  formKey.currentState?.validate() ?? false;

                              if (!valid) {
                                return;
                              }

                              if (!controller.isMobileVerified) {
                                _showMessage(
                                  context,
                                  'Please verify mobile number',
                                );
                                return;
                              }

                              if (!controller.isOtpVerified) {
                                _showMessage(
                                  context,
                                  'Please verify OTP',
                                );
                                return;
                              }

                              if (controller.panCardImage == null) {
                                _showMessage(
                                  context,
                                  'Please upload PAN card',
                                );
                                return;
                              }

                              if (controller.aadhaarFrontImage == null ||
                                  controller.aadhaarBackImage == null) {
                                _showMessage(
                                  context,
                                  'Please upload Aadhaar front and back',
                                );
                                return;
                              }

                              if (controller.livePhoto == null) {
                                _showMessage(
                                  context,
                                  'Please capture live photo',
                                );
                                return;
                              }

                              controller.submitKyc();
                            },
                    ),

                    sizedBoxHeight(height: 20),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // ============================================================
  // MESSAGE
  // ============================================================

  void _showMessage(
    BuildContext context,
    String message,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
