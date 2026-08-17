import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lekra/views/base/common_button.dart';

class ProceedToConfirmButton extends StatelessWidget {
  const ProceedToConfirmButton({
    super.key,
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      title: 'Proceed to Confirm',
      type: ButtonType.primary,
      onTap: onTap,
      height: 52.h,
      radius: 14.r,
      borderWidth: 0,
      fontSize: 14.sp,
    );
  }
}