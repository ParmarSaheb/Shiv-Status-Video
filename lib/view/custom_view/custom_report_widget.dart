import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shiv_status_video/remote/api/request_params_api.dart';
import 'package:shiv_status_video/utils/app_assets.dart';
import 'package:shiv_status_video/utils/app_color_file.dart';
import 'package:shiv_status_video/utils/app_fonts.dart';
import 'package:shiv_status_video/utils/string_file.dart';
import 'package:shiv_status_video/view_model/home/home_controller.dart';
import 'custom_gf_radio_widget.dart';
import 'custom_image_widget.dart';
import 'custom_text_widget.dart';

class CustomReportWidget extends StatelessWidget {
  const CustomReportWidget({super.key});

  @override
  Widget build(BuildContext context) {
    List contentList = [
      StringFile.offensiveContent(context),
      StringFile.irrelevantContent(context),
      StringFile.copyRightViolation(context),
      StringFile.spamOrMisleading(context),
      StringFile.religiousInsensitivity(context),
      StringFile.disrespectfulComments(context),
      StringFile.impersonation(context),
      StringFile.falseInformation(context),
      StringFile.other(context),
    ];

    TextEditingController controller = TextEditingController();

    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              backgroundColor: AppColorFile.blackColor,
              shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r)),
              insetPadding: EdgeInsets.only(left: 55.w, right: 55.w),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomTextWidget(
                      StringFile.reportContent(context),
                      AppColorFile.whiteColor,
                      16,
                      AppFonts.regularFont,
                    ),
                    const Divider(),
                    6.verticalSpace,
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: contentList.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Consumer<HomeController>(
                          builder: (context, homeController, child) {
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.w),
                                  child: CustomGFRadioWidget(
                                    validation: false,
                                    size: 20,
                                    value: index,
                                    groupValue: homeController.selectedValue,
                                    onChanged: (int? newValue) {
                                      homeController.selectValue(newValue!);
                                    },
                                    Colors.transparent,
                                    Colors.transparent,
                                    AppColorFile.mahadevThemeColor,
                                    AppColorFile.mahadevThemeColor,
                                    AppColorFile.mahadevThemeColor,
                                  ),
                                ),
                                6.horizontalSpace,
                                Expanded(
                                  child: CustomTextWidget(contentList[index].toString(),
                                      AppColorFile.whiteColor, 14, AppFonts.regularFont),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                    8.verticalSpace,
                    TextField(
                      controller: controller,
                      cursorColor: AppColorFile.mahadevThemeColor,
                      style: const TextStyle(color: AppColorFile.whiteColor),
                      decoration: InputDecoration(
                        hintText: StringFile.enterAdditionalDetails(context),
                        hintStyle: TextStyle(
                            color: AppColorFile.grey34Color,
                            fontSize: 14.sp,
                            fontFamily: AppFonts.regularFont),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColorFile.mahadevThemeColor),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColorFile.mahadevThemeColor),
                        ),
                      ),
                    ),
                    20.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildButton(() => Navigator.pop(context), StringFile.cancelReport(context)),
                        30.horizontalSpace,
                        _buildButton(() {
                          String userId = RequestParam.reportUserId;
                          String postId = RequestParam.reportPostId;
                          String text = controller.text;

                          Provider.of<HomeController>(context, listen: false)
                              .submitReport(userId, postId, text);
                          controller.text = '';
                          Navigator.pop(context);
                        }, StringFile.submit(context)),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
      child: CustomImageWidget(
        assetPath: AppAssets.reportIcon,
        height: 26.w,
        width: 26.w,
      ),
    );
  }

  Widget _buildButton(VoidCallback onTap, String text) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.w),
          decoration: BoxDecoration(color: AppColorFile.mahadevThemeColor, borderRadius: BorderRadius.circular(6.r)),
          child: CustomTextWidget(text, AppColorFile.whiteColor, 14, AppFonts.semiBold),
        ),
      ),
    );
  }
}
