import 'package:provider/provider.dart';
import 'package:shiv_status_video/view_model/liked_provider.dart';

import 'view_model/app_change_category/app_change_controller.dart';
import 'view_model/bottom_navigation_bar/bottom_navigation_bar_controller.dart';
import 'view_model/darshan/darshan_controller.dart';
import 'view_model/home/home_controller.dart';
import 'view_model/language/language_controller.dart';
import 'view_model/reels/reels_controller.dart';
import 'view_model/save/save_controller.dart';

class ProviderControllerRoutes {
  static List<ChangeNotifierProvider> getProviders() {
    return [
      ChangeNotifierProvider<LanguageController>(create: (_) => LanguageController()),
      ChangeNotifierProvider<HomeController>(create: (_) => HomeController()),
      ChangeNotifierProvider<BottomNavigationBarController>(create: (_) => BottomNavigationBarController()),
      ChangeNotifierProvider<DarshanController>(create: (_) => DarshanController()),
      ChangeNotifierProvider<ReelsController>(create: (_) => ReelsController()),
      ChangeNotifierProvider<SaveController>(create: (_) => SaveController()),
      // ChangeNotifierProvider<NetworkController>(create: (_) => NetworkController()),
      ChangeNotifierProvider<AppChangesController>(create: (_) => AppChangesController()),
      ChangeNotifierProvider<LikedProvider>(create: (_) => LikedProvider()),
    ];
  }
}
