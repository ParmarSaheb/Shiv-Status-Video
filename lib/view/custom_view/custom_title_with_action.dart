import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shiv_status_video/utils/app_color_file.dart';
import 'package:shiv_status_video/utils/app_fonts.dart';
import 'package:shiv_status_video/utils/string_file.dart';
import 'custom_text_widget.dart';

class CustomTitleWithAction extends StatelessWidget {
  final String title;
  final VoidCallback onActionPressed;

  const CustomTitleWithAction({
    super.key,
    required this.title,
    required this.onActionPressed,
  });

  Widget buildTitle(String title, VoidCallback? onPressed, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: CustomTextWidget(
              title,
              AppColorFile.whiteColor,
              16,
              AppFonts.regularFont,
            ),
          ),
          TextButton(
            onPressed: onPressed,
            child: CustomTextWidget(
              StringFile.seeAll(context),
              AppColorFile.mahadevThemeColor,
              16,
              AppFonts.regularFont,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildTitle(title, onActionPressed, context);
  }
}
