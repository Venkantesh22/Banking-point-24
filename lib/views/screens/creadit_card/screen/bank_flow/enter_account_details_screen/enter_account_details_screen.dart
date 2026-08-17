import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/theme.dart';
import 'package:lekra/views/base/common_button.dart';
import 'package:lekra/views/screens/creadit_card/screen/bank_flow/account_verified_screen/account_verified_screen.dart';
import 'package:lekra/views/screens/creadit_card/screen/bank_flow/enter_account_details_screen/widget/account_details_header.dart';
import 'package:lekra/views/screens/creadit_card/screen/bank_flow/enter_account_details_screen/widget/med_section_account.dart';

class EnterAccountDetailsScreen extends StatefulWidget {
  const EnterAccountDetailsScreen({
    super.key,
  });

  @override
  State<EnterAccountDetailsScreen> createState() =>
      _EnterAccountDetailsScreenState();
}

class _EnterAccountDetailsScreenState extends State<EnterAccountDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundLight,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppConstants.screenPadding,
          child: Column(
            children: [
              const AccountDetailsHeader(),
              MedSectionOfAccount(),
              sizedBoxHeight(height: 100),
              CustomButton(
                title: 'Verify Account',
                type: ButtonType.primary,
                height: 52.h,
                radius: 14.r,
                borderWidth: 0,
                fontSize: 14.sp,
                onTap: () {
                  navigate(context: context, page: AccountVerifiedScreen());
                },
              ),
              sizedBoxHeight(height: 18),
              const _SecurityMessage(),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// SECURITY MESSAGE
// ============================================================

class _SecurityMessage extends StatelessWidget {
  const _SecurityMessage();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: primaryColorLight,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color: primaryColor.withValues(alpha: 0.10),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 38.w,
            height: 38.h,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: white,
            ),
            child: Icon(
              Icons.security_rounded,
              size: 20.sp,
              color: primaryColor,
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Secure Bank Settlement',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                        color: textPrimary,
                      ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Please enter the customer bank details '
                  'carefully. The account will be verified '
                  'before sending money.',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 10.5.sp,
                        height: 1.45,
                        color: textSecondary,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
