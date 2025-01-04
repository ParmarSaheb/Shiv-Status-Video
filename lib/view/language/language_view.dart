import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shiv_status_video/routes.dart';
import 'package:shiv_status_video/utils/app_assets.dart';
import 'package:shiv_status_video/utils/app_color_file.dart';
import 'package:provider/provider.dart';
import 'package:shiv_status_video/utils/app_fonts.dart';
import 'package:shiv_status_video/utils/common.dart';
import 'package:shiv_status_video/utils/string_file.dart';
import 'package:shiv_status_video/view/bottom_navigation_bar/bottom_navigation_bar_view.dart';
import 'package:shiv_status_video/view/custom_view/custom_button.dart';
import 'package:shiv_status_video/view/custom_view/custom_image_widget.dart';
import 'package:shiv_status_video/view/custom_view/custom_language_show_toast.dart';
import 'package:shiv_status_video/view/custom_view/custom_text_widget.dart';
import 'package:shiv_status_video/view/language/language_shimmer_view.dart';
import 'package:shiv_status_video/view_model/app_change_category/app_change_controller.dart';
import 'package:shiv_status_video/view_model/language/language_controller.dart';

class LanguageView extends StatelessWidget {
  const LanguageView({super.key, required this.isSplashLanguage});

  final bool isSplashLanguage;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColorFile.blackColor,
        body: isSplashLanguage ? menuItemLanguage(context) : chooseLanguage(),
      ),
    );
  }
}

// Widget menuItemLanguage(BuildContext context) {
//   return Consumer<LanguageController>(
//     builder: (context, languageController, child) => Padding(
//       padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 20.w),
//       child: Column(
//         children: [
//           AppBar(
//             backgroundColor: AppColorFile.blackColor,
//             leading: GestureDetector(
//               onTap: () async {
//
//                 await languageController.selectLanguage(languageController.selectedIndex - 1);
//
//                   Navigator.pop(context);
//               },
//               child: CustomImageWidget(
//                 assetPath: AppAssets.mahadevBackIcon,
//                 height: 36.w,
//                 width: 36.w,
//               ),
//             ),
//             title: CustomTextWidget(StringFile.language(context),
//                 AppColorFile.whiteColor, 22, AppFonts.akayaFonts),
//             actions: [
//               CustomButton(
//                 onTap: () async {
//                   await languageController.selectLanguage(languageController.selectedIndex);
//
//                   Navigator.push(context, PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) => BottomNavigationBarView(),
//                     transitionsBuilder: (context, animation, secondaryAnimation, child) {
//                       return FadeTransition(
//                         opacity: animation,
//                         child: child,
//                       );
//                     },
//                     barrierColor: AppColorFile.whiteColor,
//                     reverseTransitionDuration: const Duration(milliseconds: 400),
//                     transitionDuration: const Duration(milliseconds: 800)
//                   ));
//
//                   Common.showToast(context, StringFile.languageChangeSuccessfully(context));
//                 },
//                 padding: EdgeInsets.only(bottom: 7.w, top: 7.w),
//                 borderRadius: BorderRadius.circular(8.r),
//                 width: 60.w,
//                 color: AppColorFile.themeColor,
//                 text: StringFile.done(context),
//                 textColor: AppColorFile.whiteColor,
//                 fontSize: 14.w,
//                 fontFamily: AppFonts.regularFont,
//                 textAlign: TextAlign.center,
//               )
//             ],
//           ),
//           32.verticalSpace,
//           Expanded(
//             child: languageController.isLoading
//                 ? const LanguageMenuItemShimmerView()
//                 : ListView.builder(
//                     itemCount: languageController.languageResponseData.length,
//                     physics: const NeverScrollableScrollPhysics(),
//                     itemBuilder: (context, index) {
//                       return Padding(
//                         padding: EdgeInsets.only(bottom: 10.w),
//                         child: Container(
//                           padding: EdgeInsets.symmetric(
//                               vertical: 8.w, horizontal: 10.w),
//                           decoration: BoxDecoration(
//                               color: languageController.selectedIndex == index
//                                   ? AppColorFile.themeColor
//                                   : AppColorFile.blackColor,
//                               borderRadius: BorderRadius.circular(10.r)),
//                           child: GestureDetector(
//                             onTap: () async {
//                               await languageController.selectLanguage(index);
//                             },
//                             child: Row(
//                               children: [
//                                 Common().buildContainerBg(
//                                   child: ClipRRect(
//                                     borderRadius: BorderRadius.circular(18.r),
//                                     child: CustomImageWidget(
//                                       imageUrl: languageController
//                                           .languageResponseData[index].icon.toString(),
//                                       height: 32.w,
//                                       width: 32.w,
//                                     ),
//                                   ),
//                                 ),
//                                 18.horizontalSpace,
//                                 CustomTextWidget(
//                                     languageController
//                                         .languageResponseData[index].name
//                                         .toString(),
//                                     AppColorFile.whiteColor,
//                                     16,
//                                     AppFonts.regularFont),
//                                 const Spacer(),
//                                 if (languageController.selectedIndex == index)
//                                   CustomImageWidget(
//                                     assetPath: AppAssets.checkIcon,
//                                     height: 24.w,
//                                     width: 24.w,
//                                   ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//           ),
//         ],
//       ),
//     ),
//   );
// }

Widget menuItemLanguage(BuildContext context) {
  final appChangesController = AppChangesController().selectedAppChange;
  return Consumer<LanguageController>(
    builder: (context, languageController, child) => Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 20.w),
      child: Column(
        children: [
          AppBar(
            backgroundColor: AppColorFile.blackColor,
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: CustomImageWidget(
                assetPath: appChangesController.backIcon,
                height: 36.w,
                width: 36.w,
              ),
            ),
            title: CustomTextWidget(
                StringFile.language(context), AppColorFile.whiteColor, 22, AppFonts.akayaFonts),
            actions: [
              CustomButton(
                onTap: () async {
                  await languageController.selectLanguage(languageController.tempSelectedIndex);

                  if (context.mounted) {
                    Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                            pageBuilder: (context, animation, secondaryAnimation) =>
                                const BottomNavigationBarView(),
                            transitionsBuilder: (context, animation, secondaryAnimation, child) {
                              return FadeTransition(
                                opacity: animation,
                                child: child,
                              );
                            },
                            barrierColor: AppColorFile.whiteColor,
                            reverseTransitionDuration: const Duration(milliseconds: 600),
                            transitionDuration: const Duration(milliseconds: 1000)));

                    customDialog(context);
                  }
                },
                padding: EdgeInsets.only(bottom: 7.w, top: 7.w),
                borderRadius: BorderRadius.circular(8.r),
                width: 60.w,
                color: appChangesController.themeColor,
                text: StringFile.done(context),
                textColor: AppColorFile.whiteColor,
                fontSize: 14.w,
                fontFamily: AppFonts.regularFont,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          32.verticalSpace,
          Expanded(
            child: languageController.isLoading
                ? const LanguageMenuItemShimmerView()
                : ListView.builder(
                    itemCount: languageController.languageResponseData.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 10.w),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 8.w, horizontal: 10.w),
                          decoration: BoxDecoration(
                              color: languageController.tempSelectedIndex == index
                                  ? appChangesController.itemSelectColor
                                  : AppColorFile.blackColor,
                              borderRadius: BorderRadius.circular(10.r)),
                          child: GestureDetector(
                            onTap: () {
                              languageController.selectTempLanguage(index);
                            },
                            child: Row(
                              children: [
                                Common().buildContainerBg(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(18.r),
                                    child: CustomImageWidget(
                                      imageUrl:
                                          languageController.languageResponseData[index].icon.toString(),
                                      height: 32.w,
                                      width: 32.w,
                                    ),
                                  ),
                                ),
                                18.horizontalSpace,
                                CustomTextWidget(
                                    languageController.languageResponseData[index].name.toString(),
                                    AppColorFile.whiteColor,
                                    16,
                                    AppFonts.regularFont),
                                const Spacer(),
                                if (languageController.tempSelectedIndex == index)
                                  CustomImageWidget(
                                    assetPath: AppAssets.checkIcon,
                                    height: 24.w,
                                    width: 24.w,
                                  ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    ),
  );
}

Widget chooseLanguage() {
  final appChangesController = AppChangesController().selectedAppChange;
  return Consumer<LanguageController>(
    builder: (context, languageController, child) => Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.2, vertical: 20.w),
      child: languageController.isLoading
          ? const LanguageChooseShimmerView()
          : Column(
              children: [
                30.verticalSpace,
                CustomImageWidget(assetPath: appChangesController.appLogo, height: 50.h, width: 50.w),
                15.verticalSpace,
                CustomTextWidget(StringFile.chooseYourLanguage(context), AppColorFile.whiteColor, 15,
                    AppFonts.regularFont),
                24.verticalSpace,
                Expanded(
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1 / 0.7,
                      crossAxisSpacing: 20.w,
                      mainAxisSpacing: 20.h,
                    ),
                    itemCount: languageController.languageResponseData.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () async {
                          // await languageController.selectLanguage(index);
                          languageController.selectTempLanguage(index);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            color: languageController.tempSelectedIndex == index
                                ? appChangesController.itemSelectColor
                                : AppColorFile.blackColor,
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          languageController.languageResponseData[index].icon.toString())),
                                  10.verticalSpace,
                                  CustomTextWidget(
                                      languageController.languageResponseData[index].name.toString(),
                                      AppColorFile.whiteColor,
                                      16,
                                      AppFonts.regularFont)
                                ],
                              ),
                              if (languageController.tempSelectedIndex == index)
                                Positioned(
                                    right: 12.w,
                                    top: 36.h,
                                    child: CustomImageWidget(
                                      assetPath: AppAssets.checkIcon,
                                      height: 27.w,
                                      width: 27.w,
                                    )),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                CustomButton(
                  onTap: () async {
                    // await languageController.selectLanguage(languageController.selectedIndex);
                    await languageController.selectLanguage(languageController.tempSelectedIndex);

                    if (context.mounted) {
                      Navigator.of(context).pushNamed(AppRoutes.bottomNavigationBarView);

                      customDialog(context);
                    }
                  },
                  padding: const EdgeInsets.all(16.0),
                  borderRadius: BorderRadius.circular(5.r),
                  width: double.infinity,
                  color: appChangesController.themeColor,
                  text: StringFile.done(context),
                  textColor: AppColorFile.whiteColor,
                  fontSize: 14.sp,
                  fontFamily: AppFonts.regularFont,
                  textAlign: TextAlign.center,
                )
              ],
            ),
    ),
  );
}
