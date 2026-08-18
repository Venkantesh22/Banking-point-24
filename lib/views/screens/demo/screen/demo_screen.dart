import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/custom_text.dart';
import 'package:lekra/services/theme.dart';
import 'package:lekra/views/base/custom_image.dart';
import 'package:lekra/views/screens/demo/screen/screen_mode.dart';

class DemoScreen extends StatelessWidget {
  final DemoScreenModel demoScreenModel;
  const DemoScreen({super.key, required this.demoScreenModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 80.h,
        ),
        demoScreenModel.titleImage != null
            ? Padding(
                padding: EdgeInsets.only(bottom: 40.h),
                child: Center(
                  child: CustomImage(
                    path: demoScreenModel.titleImage ?? "",
                    height: 120.h,
                    width: double.infinity,
                    fit: BoxFit.contain,
                  ),
                ),
              )
            : SizedBox(),
        demoScreenModel.title,
        demoScreenModel.secondTitle,
        SizedBox(height: 9),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: CustomText(
            demoScreenModel.subTitle,
            overflow: TextOverflow.clip,
            textAlign: TextAlign.center,
            style: Helper(context).textTheme.bodyLarge?.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: greyText,
                ),
          ),
        ),
        demoScreenModel.image,
        demoScreenModel.descr != null
            ? demoScreenModel.descr ?? SizedBox()
            : SizedBox(),
      ],
    );
  }
}
