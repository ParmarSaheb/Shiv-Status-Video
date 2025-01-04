import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shiv_status_video/routes.dart';
import 'package:shiv_status_video/utils/app_assets.dart';
import 'package:shiv_status_video/utils/app_color_file.dart';
import 'package:shiv_status_video/view_model/app_change_category/app_change_controller.dart';
import 'package:shiv_status_video/view_model/language/language_controller.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    checkLanguageStatus();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   final appChangesProvider = Provider.of<AppChangesController>(context,listen: false);
    //   appChangesProvider.updateAppChange();
    // });
  }

  void checkLanguageStatus() async {
    final languageController = Provider.of<LanguageController>(context, listen: false);

    Timer(
      const Duration(seconds: 3),
      () {
        if (languageController.isFirstTime) {
          Navigator.of(context).pushNamed(AppRoutes.languageView, arguments: false);
        } else {
          Navigator.of(context).pushReplacementNamed(AppRoutes.bottomNavigationBarView);
          // Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.bottomNavigationBarView,(route) => false,);
          //  ======= pushNamedAndRemoveUntil ======= same as work to the Get.off or Get.offAll
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final appChangesController = AppChangesController().selectedAppChange;
    return Scaffold(
      backgroundColor: AppColorFile.blackColor,
      body: Stack(
        children: [
        Image.asset(appChangesController.splashBg,height: double.infinity,width: double.infinity,fit: BoxFit.cover,),
              Center(
                child: Image.asset(
                  appChangesController.splashLogo,
                  height: ScreenUtil().screenWidth,
                  width: ScreenUtil().screenWidth,
                ),
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Lottie.asset(AppAssets.lottieSplashLoader, height: 100.w, width: 100.w),
              ),
        ],
      )

    );
  }
}
