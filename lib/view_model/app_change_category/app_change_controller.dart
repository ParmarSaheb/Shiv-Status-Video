import 'package:flutter/cupertino.dart';
import 'package:shiv_status_video/enumeration/app_changes.dart';
import 'package:shiv_status_video/remote/model/get_category_god_model.dart';
import 'package:shiv_status_video/utils/app_assets.dart';
import 'package:shiv_status_video/utils/app_color_file.dart';
import 'package:shiv_status_video/utils/string_file.dart';

class AppChangesController with ChangeNotifier {
  /// Singleton instance
  // static final AppChangesProvider _instance = AppChangesProvider._internal();
  //
  // factory AppChangesProvider() => _instance;
  //
  // AppChangesProvider._internal();

  GetCategoryGod getCategoryGod = GetCategoryGod();

  final AppChanges _selectedAppChange = AppChanges.mahadev;

  AppChanges get selectedAppChange => _selectedAppChange;

  // String categoryId(){
  //   switch (_selectedAppChange) {
  //     case AppChanges.mahadev:
  //       getCategoryGod.categoryId = AppChanges.mahadev.categoryId;
  //       break;
  //     case AppChanges.hanuman:
  //       getCategoryGod.categoryId = AppChanges.hanuman.categoryId;
  //       break;
  //     case AppChanges.shreeKrishna:
  //       getCategoryGod.categoryId = AppChanges.shreeKrishna.categoryId;
  //       break;
  //     case AppChanges.shreeRam:
  //       getCategoryGod.categoryId = AppChanges.shreeRam.categoryId;
  //       break;
  //     case AppChanges.ganesha:
  //       getCategoryGod.categoryId = AppChanges.ganesha.categoryId;
  //       break;
  //     default:
  //       getCategoryGod.categoryId = AppChanges.mahadev.categoryId;
  //   }
  //   notifyListeners();
  //   return '';
  // }

  // void updateAppChange() {
  //   switch (_selectedAppChange) {
  //     case AppChanges.mahadev:
  //       _selectedAppChange = AppChanges.mahadev;
  //       break;
  //     case AppChanges.hanuman:
  //       _selectedAppChange = AppChanges.hanuman;
  //       break;
  //     case AppChanges.shreeKrishna:
  //       _selectedAppChange = AppChanges.shreeKrishna;
  //       break;
  //     case AppChanges.shreeRam:
  //       _selectedAppChange = AppChanges.shreeRam;
  //       break;
  //     case AppChanges.ganesha:
  //       _selectedAppChange = AppChanges.ganesha;
  //       break;
  //     default:
  //       _selectedAppChange = AppChanges.mahadev;
  //   }
  //   notifyListeners();
  // }

  // Future<void> appChange() {
  //   if () {
  //     const AppChanges(
  //       AppAssets.mahadevAppLogo,
  //       AppAssets.mahadevBackIcon,
  //       AppAssets.mahadevMenuIcon,
  //       AppAssets.mahadevSplashBG,
  //       AppAssets.mahadevSplashBackGround,
  //       AppColorFile.mahadevThemeColor,
  //       AppColorFile.mahadevThemeColor,
  //       '3',
  //       '5',);
  //   }
  // }

  String getLocalizedAppName(BuildContext context) {
    switch (_selectedAppChange) {
      case AppChanges.mahadev:
        return StringFile.shivVideoStatus(context);
      case AppChanges.hanuman:
        return StringFile.hanumanVideoStatus(context);
      case AppChanges.shreeKrishna:
        return StringFile.krishnaVideoStatus(context);
      case AppChanges.shreeRam:
        return StringFile.ramVideoStatus(context);
      case AppChanges.ganesha:
        return StringFile.ganeshaVideoStatus(context);
      default:
        return StringFile.shivVideoStatus(context);
    }
  }
}
