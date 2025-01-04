import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shiv_status_video/utils/app_color_file.dart';
import 'package:shiv_status_video/utils/app_fonts.dart';
import 'package:shiv_status_video/utils/string_file.dart';
import 'package:shiv_status_video/view/custom_view/custom_appbar.dart';
import 'package:shiv_status_video/view/custom_view/custom_text_widget.dart';
import 'package:shiv_status_video/view_model/app_change_category/app_change_controller.dart';
import 'package:shiv_status_video/view_model/darshan/darshan_controller.dart';
import 'darshan_photo_view.dart';
import 'darshan_videos_view.dart';

class DailyDarshanSubCategory extends StatelessWidget {
  final String categoryName;

  const DailyDarshanSubCategory({
    super.key,
    required this.categoryName,
  });

  @override
  Widget build(BuildContext context) {
    final appChangesController = AppChangesController().selectedAppChange;
    final List<Widget> tabs = [
      Tab(
          child: CustomTextWidget(
              StringFile.photos(context), AppColorFile.whiteColor, 14, AppFonts.regularFont)),
      Tab(
          child: CustomTextWidget(
              StringFile.videos(context), AppColorFile.whiteColor, 14, AppFonts.regularFont)),
    ];

    final List<Widget> tabViews = [
      const DarshanPhotoView(),
      const DarshanVideosView(),
    ];

    BoxDecoration getTabBarDecoration() {
      return BoxDecoration(
        borderRadius: BorderRadius.circular(11.r),
        color: AppColorFile.blueColor,
      );
    }

    return Scaffold(
      backgroundColor: AppColorFile.blackColor,
      body: Padding(
        padding: EdgeInsets.fromLTRB(10.w, 0.w, 10.w, 0.w),
        child: Column(
          children: [
            Consumer<DarshanController>(
                builder: (context, darshanController, child) => CustomAppBar(
                    title: categoryName,
                    onTap: () {
                      darshanController.subCategoryDarshanPhotosVideosListClear();
                      Navigator.pop(context);
                    },
                    titleFontSize: 24.sp,
                    fontFamily: AppFonts.akayaFonts,
                    leadingIcon: appChangesController.backIcon,
                  leadingIconHeight: 38.w,
                  leadingIconWidth: 38.w,
                )
                ),
            10.verticalSpace,
            Expanded(
              child: DefaultTabController(
                length: tabs.length,
                child: Column(
                  children: [
                    Container(
                      decoration: getTabBarDecoration(),
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      child: TabBar(
                        indicatorPadding: EdgeInsets.all(4.w),
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicator: BoxDecoration(
                          color: appChangesController.themeColor,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        dividerColor: Colors.transparent,
                        labelColor: Colors.black,
                        tabs: tabs,
                      ),
                    ),
                    const Divider(color: AppColorFile.blueColor),
                    Expanded(
                      child: TabBarView(
                        children: tabViews,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
