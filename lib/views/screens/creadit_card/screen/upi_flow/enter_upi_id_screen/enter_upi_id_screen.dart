import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/custom_text.dart';
import 'package:lekra/services/theme.dart';
import 'package:lekra/views/base/common_button.dart';
import 'package:lekra/views/screens/creadit_card/screen/upi_flow/confirm_pay_screen/confirm_pay_screen.dart';
import 'package:lekra/views/screens/creadit_card/screen/upi_flow/enter_upi_id_screen/widget/upi_id_header.dart';
import 'package:lekra/views/screens/creadit_card/screen/upi_flow/enter_upi_id_screen/widget/upi_id_input.dart';

class EnterUpiIdScreen extends StatefulWidget {
  const EnterUpiIdScreen({
    super.key,
  });

  @override
  State<EnterUpiIdScreen> createState() => _EnterUpiIdScreenState();
}

class _EnterUpiIdScreenState extends State<EnterUpiIdScreen> {
  // Demo UPI ID
  final TextEditingController _upiController =
      TextEditingController(text: 'rahul.kumar@okhdfcbank');

  @override
  void dispose() {
    _upiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundLight,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Padding(
          padding: AppConstants.screenPadding,
          child: Column(
            children: [
              const UpiIdHeader(),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      UpiIdInput(
                        controller: _upiController,
                      ),
                      sizedBoxHeight(height: 10),
                      GestureDetector(
                        onTap: () {
                          debugPrint('How to find UPI ID');
                        },
                        child: CustomText(
                          'How to find UPI ID?',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                        ),
                      ),
                      sizedBoxHeight(height: 24),
                    ],
                  ),
                ),
              ),
              CustomButton(
                title: "Validate UPI ID",
                onTap: () {
                  final String upiId = _upiController.text.trim();
                  debugPrint(
                    'Validate UPI ID: $upiId',
                  );
                  navigate(context: context, page: ConfirmPayScreen());
                },
              ),
              sizedBoxHeight(height: 30),
              const _UpiSecurityInfo(),
            ],
          ),
        ),
      ),
    );
  }
}

class _UpiSecurityInfo extends StatelessWidget {
  const _UpiSecurityInfo();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: primaryColorLight,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: primaryColor.withValues(alpha: 0.10),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40.w,
            height: 40.h,
            decoration: BoxDecoration(
              color: white,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.security_rounded,
              size: 21.sp,
              color: primaryColor,
            ),
          ),
          sizedBoxWidth(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  'Secure UPI Settlement',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w700,
                        color: textPrimary,
                      ),
                ),
                sizedBoxHeight(height: 4),
                CustomText(
                  'Enter the customer’s correct UPI ID. '
                  'We will verify the recipient before payment.',
                  overflow: TextOverflow.clip,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 11.sp,
                        height: 1.5,
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
