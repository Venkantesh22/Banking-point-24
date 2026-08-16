import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lekra/services/custom_text.dart';
import 'package:lekra/services/theme.dart';

class SettlementOptionWidget extends StatelessWidget {
  const SettlementOptionWidget({
    super.key,
    required this.onWantMoneyCash,
    required this.onSettlementToCustomer,
  });

  final VoidCallback onWantMoneyCash;
  final VoidCallback onSettlementToCustomer;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 118.h,
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(22.r),
        border: Border.all(
          color: greyBorder,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 14,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: _SettlementOption(
              icon: Icons.payments_outlined,
              iconColor: const Color(0xFF20A865),
              title: 'Want Money Cash',
              onTap: onWantMoneyCash,
            ),
          ),

          Container(
            width: 1,
            height: 72.h,
            color: greyBorder,
          ),

          Expanded(
            child: _SettlementOption(
              icon: Icons.account_balance_outlined,
              iconColor: primaryColor,
              title: 'Settlement to Customer',
              onTap: onSettlementToCustomer,
            ),
          ),
        ],
      ),
    );
  }
}

class _SettlementOption extends StatelessWidget {
  const _SettlementOption({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.onTap,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22.r),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 10.w,
            vertical: 14.h,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 32.sp,
                color: iconColor,
              ),

              SizedBox(height: 8.h),

              CustomText(
                title,
                maxLines: 2,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: textPrimary,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}