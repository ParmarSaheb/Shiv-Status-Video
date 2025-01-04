import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shiv_status_video/utils/app_color_file.dart';
import 'package:shiv_status_video/utils/app_fonts.dart';
import 'package:shiv_status_video/utils/string_file.dart';
import 'package:shiv_status_video/view_model/app_change_category/app_change_controller.dart';
import 'custom_text_widget.dart';

class ProgressDialog extends StatefulWidget {
  final ValueNotifier<double> progressNotifier;
  final CancelToken cancelToken;

  const ProgressDialog({
    super.key,
    required this.progressNotifier,
    required this.cancelToken,
  });

  @override
  ProgressDialogState createState() => ProgressDialogState();
}

class ProgressDialogState extends State<ProgressDialog> {
  @override
  Widget build(BuildContext context) {
    final appChangesController = AppChangesController().selectedAppChange;
    return AlertDialog(
      backgroundColor: AppColorFile.blueColor,
      title: CustomTextWidget(
          StringFile.pleaseWait(context), AppColorFile.whiteColor, 14.sp, AppFonts.regularFont),
      titleTextStyle: TextStyle(fontWeight: FontWeight.bold, color: AppColorFile.whiteColor, fontSize: 20.sp),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.r))),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ValueListenableBuilder<double>(
            valueListenable: widget.progressNotifier,
            builder: (context, progress, child) {
              return Column(
                children: [
                  LinearProgressIndicator(
                    value: progress / 100,
                    backgroundColor: Colors.white,
                    valueColor: AlwaysStoppedAnimation<Color>(appChangesController.themeColor),
                    minHeight: 8,
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                ],
              );
            },
          ),
          10.verticalSpace,
          CustomTextWidget(StringFile.preparingFileForShareVideos(context), AppColorFile.whiteColor, 16,
              AppFonts.regularFont),
          Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                  onPressed: () => widget.cancelToken.cancel(),
                  child: CustomTextWidget(
                      StringFile.cancelReport(context), appChangesController.themeColor, 16, AppFonts.regularFont)))
        ],
      ),
    );
  }
}
