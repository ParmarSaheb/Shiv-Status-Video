import 'package:flutter/material.dart';
import 'package:shiv_status_video/utils/app_color_file.dart';
import '../utils/app_assets.dart';

// class AppChanges{
//
//   final String appLogo;
//   final String backIcon;
//   final String menuIcon;
//   final String splashLogo;
//   final String splashBg;
//   final Color themeColor;
//   final Color itemSelectColor;
//   final String categoryId;
//   final String subCategoryId;
//
//   const AppChanges(this.appLogo, this.backIcon, this.menuIcon, this.splashLogo, this.splashBg,
//       this.themeColor, this.itemSelectColor, this.categoryId, this.subCategoryId);
//
// }

enum AppChanges {
  mahadev(
    AppAssets.mahadevAppLogo,
    AppAssets.mahadevBackIcon,
    AppAssets.mahadevMenuIcon,
    AppAssets.mahadevSplashBG,
    AppAssets.mahadevSplashBackGround,
    AppColorFile.mahadevThemeColor,
    AppColorFile.mahadevThemeColor,
    '3',
    '5',
  ),
  hanuman(
    AppAssets.hanumanAppLogo,
    AppAssets.hanumanBackIcon,
    AppAssets.hanumanMenuIcon,
    AppAssets.hanumanSplashLogo,
    AppAssets.hanumanSplashBackGround,
    AppColorFile.hanumanThemeColor,
    AppColorFile.hanumanItemSelectColor,
    '8',
    '22',
  ),
  shreeKrishna(
    AppAssets.shreeKrishnaAppLogo,
    AppAssets.shreeKrishnaBackIcon,
    AppAssets.shreeKrishnaMenuIcon,
    AppAssets.shreeKrishnaSplashBG,
    AppAssets.shreeKrishnaSplashBackGround,
    AppColorFile.shreeKrishnaThemeColor,
    AppColorFile.shreeKrishnaThemeColor,
    '7',
    '32',
  ),
  shreeRam(
    AppAssets.shreeRamAppLogo,
    AppAssets.shreeRamBackIcon,
    AppAssets.shreeRamMenuIcon,
    AppAssets.shreeRamSplashBG,
    AppAssets.shreeRamSplashBackGround,
    AppColorFile.shreeRamThemeColor,
    AppColorFile.shreeRamThemeColor,
    '12',
    '43',
  ),
  ganesha(
    AppAssets.ganeshaAppLogo,
    AppAssets.ganeshaBackIcon,
    AppAssets.ganeshaMenuIcon,
    AppAssets.ganeshaSplashLogo,
    AppAssets.ganeshaSplashBackGround,
    AppColorFile.ganeshaThemeColor,
    AppColorFile.ganeshaItemSelectColor,
    '2',
    '4',
  );

  final String appLogo;
  final String backIcon;
  final String menuIcon;
  final String splashLogo;
  final String splashBg;
  final Color themeColor;
  final Color itemSelectColor;
  final String categoryId;
  final String subCategoryId;

  const AppChanges(this.appLogo, this.backIcon, this.menuIcon, this.splashLogo, this.splashBg,
      this.themeColor, this.itemSelectColor, this.categoryId, this.subCategoryId);
}
