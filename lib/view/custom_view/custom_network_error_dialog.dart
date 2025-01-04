import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shiv_status_video/utils/app_color_file.dart';
import 'package:shiv_status_video/utils/app_fonts.dart';
import 'package:shiv_status_video/utils/string_file.dart';
import 'custom_text_widget.dart';

class CustomNetworkErrorDialog extends StatelessWidget {
  const CustomNetworkErrorDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140.h,
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.w),
      width: double.infinity,
      decoration: BoxDecoration(color: AppColorFile.whiteColor, borderRadius: BorderRadius.circular(4.r)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextWidget(
              StringFile.noInternetConnection(context), AppColorFile.blackColor, 16.sp, AppFonts.semiBold),
          8.verticalSpace,
          CustomTextWidget(StringFile.turnOnInternetAndRetry(context), AppColorFile.blackColor, 12.sp,
              AppFonts.mediumFont),
          const Spacer(),
          Align(
            alignment: Alignment.bottomRight,
            child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: CustomTextWidget(
                    StringFile.ok(context), AppColorFile.mahadevThemeColor, 14.sp, AppFonts.mediumFont)),
          )
        ],
      ),
    );
  }
}
