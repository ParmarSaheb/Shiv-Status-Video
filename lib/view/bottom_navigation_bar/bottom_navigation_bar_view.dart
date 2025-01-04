import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shiv_status_video/utils/app_assets.dart';
import 'package:shiv_status_video/utils/app_color_file.dart';
import 'package:shiv_status_video/utils/app_fonts.dart';
import 'package:shiv_status_video/utils/common.dart';
import 'package:shiv_status_video/utils/string_file.dart';
import 'package:shiv_status_video/view/custom_view/custom_appbar.dart';
import 'package:shiv_status_video/view/custom_view/custom_drawer_widget.dart';
import 'package:shiv_status_video/view/custom_view/custom_image_widget.dart';
import 'package:shiv_status_video/view/darshan/darshan_view.dart';
import 'package:shiv_status_video/view/home/home_view.dart';
import 'package:shiv_status_video/view/reels/reels_view.dart';
import 'package:shiv_status_video/view/save/save_view.dart';
import 'package:shiv_status_video/view_model/app_change_category/app_change_controller.dart';
import 'package:shiv_status_video/view_model/bottom_navigation_bar/bottom_navigation_bar_controller.dart';

class BottomNavigationBarView extends StatefulWidget {
  const BottomNavigationBarView({super.key});

  @override
  State<BottomNavigationBarView> createState() => _BottomNavigationBarViewState();
}

class _BottomNavigationBarViewState extends State<BottomNavigationBarView> {
  final List<Widget> _screens = [
    const HomeView(),
    const DarshanView(),
    const ReelsView(),
    const SaveView(),
  ];

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final appChangeController = AppChangesController().selectedAppChange;

    final bottomNavProvider = Provider.of<BottomNavigationBarController>(context);

    // final networkController = Provider.of<NetworkController>(context);

    Future<bool> onWillPop() async {
      if (bottomNavProvider.selectedIndex == 0) {
        final shouldExit = await Common.showExitDialog(context);
        if (shouldExit) {
          SystemNavigator.pop();
          return true;
        }
        return shouldExit;
      } else {
        bottomNavProvider.updateIndex(0);
        return false;
      }
    }

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   if (!networkController.isConnectedToInternet.value) {
    //     networkController.showDialogBox(context);
    //   }
    // });

    return PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) async {
          if (didPop == false) {
            await onWillPop();
          }
        },
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: AppColorFile.blackColor,
          drawer: const CustomDrawer(),
          body: Padding(
            padding: bottomNavProvider.selectedIndex != 2
                ? EdgeInsets.fromLTRB(10.w, 0.w, 10.w, 0.w)
                : EdgeInsets.all(0.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (bottomNavProvider.selectedIndex != 2) ...[
                  CustomAppBar(
                      title: AppChangesController().getLocalizedAppName(context),
                      onTap: () => scaffoldKey.currentState?.openDrawer(),
                      titleFontSize: 24.sp,
                      fontFamily: AppFonts.akayaFonts,
                      leadingIcon: appChangeController.menuIcon,
                      leadingIconHeight: 38.w,
                      leadingIconWidth: 38.w)

                  // CustomAppBar(
                  //   onTap: () => scaffoldKey.currentState?.openDrawer(),
                  //   leadingIcon: appChangeController.menuIcon,
                  //   title: AppChangesController().getLocalizedAppName(context),
                  //   titleFontSize: 24.sp,
                  //   fontFamily: AppFonts.akayaFonts,
                  //   leadingIconHeight: 10.w,
                  //   leadingIconWidth: 10.w,
                  // ),
                ],
                14.verticalSpace,
                Expanded(child: _screens[bottomNavProvider.selectedIndex])
              ],
            ),
          ),

          bottomNavigationBar: BottomNavigationBar(
            currentIndex: bottomNavProvider.selectedIndex,
            onTap: (value) {
              bottomNavProvider.updateIndex(value);
            },
            useLegacyColorScheme: false,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            backgroundColor: AppColorFile.whiteColor,
            items: [
              _buildBottomNavItem(AppAssets.icHome, StringFile.home(context), 0, bottomNavProvider),
              _buildBottomNavItem(AppAssets.icPray, StringFile.darshan(context), 1, bottomNavProvider),
              _buildBottomNavItem(AppAssets.icReels, StringFile.reels(context), 2, bottomNavProvider),
              _buildBottomNavItem(AppAssets.icSave, StringFile.save(context), 3, bottomNavProvider),
            ],
            unselectedItemColor: AppColorFile.blackColor,
            selectedLabelStyle: TextStyle(
                fontSize: AppFonts.fontSize31,
                color: appChangeController.themeColor,
                fontFamily: AppFonts.semiBold),
            unselectedLabelStyle: TextStyle(
                fontSize: AppFonts.fontSize31,
                color: AppColorFile.blackColor,
                fontFamily: AppFonts.mediumFont),
            type: BottomNavigationBarType.fixed,
          ),
        ));
  }

  BottomNavigationBarItem _buildBottomNavItem(
      String iconPath, String label, int index, BottomNavigationBarController provider) {
    final appChangeController = AppChangesController().selectedAppChange;
    return BottomNavigationBarItem(
      tooltip: label,
      icon: CustomImageWidget(
        assetPath: iconPath,
        height: 25,
        width: 25,
        color: provider.selectedIndex == index ? appChangeController.themeColor : AppColorFile.blackColor,
        isSvg: true,
      ),
      label: label,
    );
  }
}
