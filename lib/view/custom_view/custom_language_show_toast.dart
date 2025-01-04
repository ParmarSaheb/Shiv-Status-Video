import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shiv_status_video/utils/app_color_file.dart';
import 'package:shiv_status_video/utils/app_fonts.dart';
import 'package:shiv_status_video/utils/string_file.dart';
import 'package:shiv_status_video/view/custom_view/custom_image_widget.dart';
import 'package:shiv_status_video/view/custom_view/custom_text_widget.dart';
import 'package:shiv_status_video/view_model/app_change_category/app_change_controller.dart';

Future customDialog(BuildContext context) {
  final appChangesController = AppChangesController().selectedAppChange;
  return showDialog(
    barrierColor: Colors.transparent,
    context: context,
    builder: (context) {
      Future.delayed(const Duration(seconds: 2), () {
        if (context.mounted) Navigator.of(context).pop();
      });

      return Stack(
        children: [
          Positioned(
            bottom: 90.h,
            left: 34.w,
            right: 34.w,
            child: Material(
              color: Colors.transparent,
              child: Center(
                child: IntrinsicWidth(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
                    decoration: BoxDecoration(
                      color: AppColorFile.whiteColor,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4.r),
                          child: CustomImageWidget(
                            assetPath: appChangesController.appLogo,
                            height: 22.w,
                            width: 22.w,
                          ),
                        ),
                        10.horizontalSpace,
                        Flexible(
                          child: CustomTextWidget(
                            StringFile.languageChangeSuccessfully(context),
                            AppColorFile.blackColor,
                            16,
                            AppFonts.mediumFont,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}
