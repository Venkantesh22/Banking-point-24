// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// import 'package:lekra/services/theme.dart';

// class UpiIdInput extends StatelessWidget {
//   const UpiIdInput({
//     super.key,
//     required this.controller,
//   });

//   final TextEditingController controller;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 54.h,
//       decoration: BoxDecoration(
//         color: white,
//         borderRadius: BorderRadius.circular(14.r),
//         border: Border.all(
//           color: greyBorder,
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withValues(alpha: 0.02),
//             blurRadius: 8,
//             offset: const Offset(0, 3),
//           ),
//         ],
//       ),
//       child: TextField(
//         controller: controller,
//         keyboardType: TextInputType.text,
//         textInputAction: TextInputAction.done,
//         style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//               fontSize: 14.sp,
//               fontWeight: FontWeight.w500,
//               color: textPrimary,
//             ),
//         decoration: InputDecoration(
//           hintText: 'Enter UPI ID',
//           hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                 fontSize: 14.sp,
//                 color: greyText4,
//               ),
//           contentPadding: EdgeInsets.symmetric(
//             horizontal: 16.w,
//             vertical: 15.h,
//           ),
//           border: InputBorder.none,
//           suffixIcon: IconButton(
//             onPressed: () {
//               controller.clear();
//             },
//             icon: Container(
//               width: 18.w,
//               height: 18.h,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: greyText4,
//               ),
//               child: Icon(
//                 Icons.close_rounded,
//                 size: 12.sp,
//                 color: white,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lekra/services/custom_text.dart';
import 'package:lekra/services/theme.dart';
import 'package:lekra/views/screens/widget/text_box/app_text_box.dart';

class UpiIdInput extends StatelessWidget {
  const UpiIdInput({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return AppTextFieldWithHeading(
      controller: controller,
      headingWidget: CustomText(
        'UPI ID',
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: textPrimary,
            ),
      ),
      hindText: 'Enter UPI ID',
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.done,
      borderRadius: 14.r,
      borderWidth: 1,
      borderColor: greyBorder,
      bgColor: white,
      suffix: IconButton(
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
        onPressed: () {
          controller.clear();
        },
        icon: Container(
          width: 18.w,
          height: 18.h,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFF9CA3AF),
          ),
          child: Icon(
            Icons.close_rounded,
            size: 12.sp,
            color: white,
          ),
        ),
      ),
    );
  }
}
