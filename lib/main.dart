import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shiv_status_video/dependency_injection/dependency_injection_screen.dart';
import 'package:shiv_status_video/provider.dart';
import 'package:shiv_status_video/routes.dart';
import 'package:shiv_status_video/shared_preferences/liked_prefs.dart';
import 'package:shiv_status_video/utils/app_color_file.dart';
import 'package:shiv_status_video/utils/string_file.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'view_model/language/language_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LikedPrefs.init();
  DependencyInjection().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: AppColorFile.blackColor, statusBarIconBrightness: Brightness.light));

    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        child: MultiProvider(
            providers: ProviderControllerRoutes.getProviders(),
            child: Consumer<LanguageController>(
              builder: (context, languageController, child) {
                return MaterialApp(
                  title: StringFile.appName,
                  navigatorKey: MyApp.navigatorKey,
                  locale: languageController.locale,
                  localizationsDelegates: AppLocalizations.localizationsDelegates,
                  supportedLocales: AppLocalizations.supportedLocales,
                  debugShowCheckedModeBanner: false,
                  theme: ThemeData(
                    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                    useMaterial3: true,
                  ),
                  onGenerateRoute: AppRoutes.onGenerateRoute,
                  initialRoute: AppRoutes.initialRoute,
                );
              },
            )));
  }
}
