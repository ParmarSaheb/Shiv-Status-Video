import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shiv_status_video/utils/app_color_file.dart';
import 'package:shiv_status_video/utils/app_fonts.dart';
import 'package:shiv_status_video/utils/string_file.dart';
import 'package:shiv_status_video/view/custom_view/custom_text_widget.dart';
import 'package:shiv_status_video/view/save/download/download_view.dart';
import 'package:shiv_status_video/view_model/app_change_category/app_change_controller.dart';
import 'favourites/favourites_view.dart';

class SaveView extends StatelessWidget {
  const SaveView({super.key});

  @override
  Widget build(BuildContext context) {
    final appChangesController = AppChangesController().selectedAppChange;

    final List<Widget> tabs = [
      Tab(
          child: CustomTextWidget(
              StringFile.favourite(context), AppColorFile.whiteColor, 14, AppFonts.regularFont)),
      Tab(
          child: CustomTextWidget(
              StringFile.download(context), AppColorFile.whiteColor, 14, AppFonts.regularFont)),
    ];

    final List<Widget> tabViews = [
      const FavouritesView(),
      const DownloadView(),
    ];

    BoxDecoration getTabBarDecoration() {
      return BoxDecoration(
        borderRadius: BorderRadius.circular(11.r),
        color: AppColorFile.blueColor,
      );
    }

    return Scaffold(
      backgroundColor: AppColorFile.blackColor,
      body: DefaultTabController(
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
                  // color: AppColorFile.themeColor,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                dividerColor: Colors.transparent,
                labelColor: Colors.black,
                tabs: tabs,
              ),
            ),
            const Divider(
              color: AppColorFile.blueColor,
            ),
            Expanded(
              child: TabBarView(
                children: tabViews,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
