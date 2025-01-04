import 'dart:developer';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shiv_status_video/remote/api/api_urls.dart';
import 'package:shiv_status_video/remote/api/request_params_api.dart';
import 'package:shiv_status_video/repository/get_user_id_repository/get_user_repository_id.dart';
import 'package:shiv_status_video/repository/shared_prefrence_repository/shared_preferences_repository.dart';
import 'package:shiv_status_video/utils/string_file.dart';
import 'package:shiv_status_video/view/custom_view/custom_button.dart';
import 'package:shiv_status_video/view/custom_view/custom_image_widget.dart';
import 'package:shiv_status_video/view/custom_view/custom_text_widget.dart';
import 'package:shiv_status_video/view_model/app_change_category/app_change_controller.dart';
import 'app_assets.dart';
import 'app_color_file.dart';
import 'app_fonts.dart';

class Common extends ChangeNotifier {
  // static String userId = RequestParam.userID;
  static String? userId;
  static String reelEndPoint = "";
  static int language = (2);
  static final sharedPreferencesRepository = SharedPreferencesRepository();

  static Future<void> initializeUserId() async {
    userId = await sharedPreferencesRepository.mLoadUserId();
    log('user id is ============ $userId');
    if (userId == null) {
      final GetUserIdRepository repository = GetUserIdRepository();
      userId = await repository.mGetUserIdData();
      if (userId != null) {
        await sharedPreferencesRepository.mSaveUserId(userId!);
      }
    }
  }

  static Future<void> fetchDelay({int seconds = 3}) async {
    await Future.delayed(Duration(seconds: seconds));
  }

  static String getCategoryEndPoint() {
    String categoryEndPoint = "${RequestParam.language}=$language";
    return ApiBaseUrls.getCategories + categoryEndPoint;
  }

  // static String categories = '12';
  // static String category = '43';

  static String getReelsUrl(int page, {int? categoryId}) {
    final appChangeController = AppChangesController().selectedAppChange;
    reelEndPoint = "${RequestParam.page}=$page&${RequestParam.userId}=$userId";
    if (categoryId != null) {
      // reelEndPoint += "&${RequestParam.categories}=$categoryId";
      reelEndPoint += "&${RequestParam.categories}=${appChangeController.categoryId}";
    }
    return ApiBaseUrls.getReels + reelEndPoint;
  }

  static String getRandomReelsUrl(int page, {String categoryId = '3'}) {
    final appChangeController = AppChangesController().selectedAppChange;
    reelEndPoint =
        // "${RequestParam.page}=$page&${RequestParam.userId}=$userId&${RequestParam.categories}=$categoryId";
        "${RequestParam.page}=$page&${RequestParam.userId}=$userId&${RequestParam.categories}=${appChangeController.categoryId}";
    return ApiBaseUrls.getReels + reelEndPoint;
  }

  static const MethodChannel _channel = MethodChannel(RequestParam.shareToWhatsapp);

  Future<void> shareFile(String filePath, String text) async {
    try {
      await _channel.invokeMethod(RequestParam.shareFile, {
        RequestParam.filePath: filePath,
        RequestParam.text: text,
      });
    } on PlatformException catch (e) {
      debugPrint("Failed to share file: '${e.message}'.");
    }
  }

  static void loadMoreReels({
    required int currentPage,
    required int totalPages,
    required int perPage,
    required Future<void> Function() fetchReelCategoryFromPage,
    List<dynamic>? pageNationList,
  }) async {
    if (currentPage < totalPages && (pageNationList?.length ?? 0) <= (currentPage * perPage) + 1) {
      currentPage++;
      await fetchReelCategoryFromPage();
    }
  }

  static String getDarshanVideosUrl({
    int? subCategories,
    page,
  }) {
    if (subCategories != null) {
      reelEndPoint =
          "${RequestParam.language}=$language&${RequestParam.userId}=$userId&${RequestParam.subCategories}=$subCategories&${RequestParam.page}=$page";
    }
    return ApiBaseUrls.getDarshanVideos + reelEndPoint;
  }

  static String getDarshanPhotoUrl({
    int? subCategories,
    page,
  }) {
    if (subCategories != null) {
      reelEndPoint =
          "${RequestParam.language}=$language&${RequestParam.userId}=$userId&${RequestParam.subCategories}=$subCategories&${RequestParam.page}=$page";
    }

    return ApiBaseUrls.getDarshanPhotos + reelEndPoint;
  }

  static Widget menuItem({
    required BuildContext context,
    required String icon,
    required String title,
    void Function()? onTap,
  }) {
    return ListTile(
      onTap: onTap,
      leading: CustomImageWidget(
        assetPath: icon,
        height: 35.w,
        width: 35.w,
      ),
      title: CustomTextWidget(
        title,
        AppColorFile.whiteColor,
        16,
        AppFonts.regularFont,
      ),
    );
  }

  static void showToast(BuildContext context, String message) {
    final appChangeController = AppChangesController().selectedAppChange;
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      canSizeOverlay: false,
      builder: (context) => Positioned(
        bottom: 90.h,
        left: 34.w,
        right: 34.w,
        child: Material(
          color: Colors.transparent,
          child: Center(
            child: IntrinsicWidth(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
                decoration: BoxDecoration(
                  color: AppColorFile.whiteColor,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4.r),
                      child: CustomImageWidget(
                        assetPath: appChangeController.appLogo,
                        height: 22.w,
                        width: 22.w,
                      ),
                    ),
                    10.horizontalSpace,
                    Flexible(
                      child: CustomTextWidget(
                        message,
                        AppColorFile.blackColor,
                        16,
                        AppFonts.mediumFont,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);
    Future.delayed(const Duration(seconds: 2), () {
      overlayEntry.remove();
    });
  }

  static showExitDialog(BuildContext context) async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: AppColorFile.blackColor,
            icon: Image.asset(
              AppAssets.exitIcon,
              height: 80.h,
              width: 80.w,
            ),
            title: Center(
                child: CustomTextWidget(StringFile.exit(context), AppColorFile.whiteColor,
                    AppFonts.fontSize40, AppFonts.semiBold)),
            content: CustomTextWidget(
              StringFile.areYouSureYouWantToCloseTheApp(context),
              AppColorFile.whiteColor,
              AppFonts.fontSize35,
              AppFonts.mediumFont,
              textAlign: TextAlign.center,
            ),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: CustomButton(
                    text: StringFile.exit(context),
                    color: AppColorFile.blueColor,
                    textAlign: TextAlign.center,
                    textColor: AppColorFile.whiteColor,
                    fontFamily: AppFonts.regularFont,
                    fontSize: 16.sp,
                    padding: EdgeInsets.symmetric(vertical: 8.w),
                    borderRadius: BorderRadius.circular(8.r),
                    onTap: () => Navigator.of(context).pop(true),
                  )),
                  10.horizontalSpace,
                  Expanded(
                      child: CustomButton(
                    text: StringFile.cancel(context),
                    color: AppColorFile.mahadevThemeColor,
                    textAlign: TextAlign.center,
                    textColor: AppColorFile.whiteColor,
                    fontFamily: AppFonts.regularFont,
                    fontSize: 18,
                    padding: EdgeInsets.symmetric(vertical: 8.w),
                    borderRadius: BorderRadius.circular(8.r),
                    onTap: () => Navigator.of(context).pop(false),
                  ))
                ],
              ),
            ],
          ),
        ) ??
        false;
  }

  // Darshan
  static String getSubcategoryUrl({int? categoryId, int? languageId}) {
    final selectedApp = AppChangesController().selectedAppChange;
    if (categoryId != null) {
      // reelEndPoint = "&${RequestParam.category}=$category&${RequestParam.language}=$languageId";
      reelEndPoint =
          "&${RequestParam.category}=${selectedApp.subCategoryId}&${RequestParam.language}=$languageId";
    }
    return ApiBaseUrls.getSubCategories + reelEndPoint;
  }

  // action button
  double iconHeight = 35.h;
  double iconWidth = 35.h;

  actionButton(String savePath, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          icon: SvgPicture.asset(AppAssets.icWhatsappLogo, height: iconHeight, width: iconWidth),
          onPressed: () async {
            try {
              await socialShareFile(savePath, true, context);
            } catch (e) {
              log('Failed to share');
            }
          },
        ),
        IconButton(
          icon: SvgPicture.asset(AppAssets.icSend, height: iconHeight, width: iconWidth),
          onPressed: () async {
            try {
              await socialShareFile(savePath, false, context);
            } catch (e) {
              log('Failed to share');
            }
          },
        ),
      ],
    );
  }

  Future<void> socialShareFile(String savePath, bool isWhatsApp, BuildContext context) async {
    String xStreamFile = Uri.parse(savePath).pathSegments.last;

    var sharingFile = path.join(RequestParam.saveVideoDirPath, xStreamFile);
    final file = File(sharingFile);
    debugPrint(file.toString());
    if (await file.exists()) {
      if (isWhatsApp) {
        if (context.mounted) await Common().shareFile(sharingFile, StringFile.sendMessage(context));
      } else {
        final vPath = XFile(sharingFile);
        if (context.mounted) await Share.shareXFiles([vPath], text: StringFile.sendMessage(context));
      }
    }
  }

  // void showCustomSnackBar(String message) {
  //   final snackBar = SnackBar(
  //     content: CustomTextWidget(message, Colors.red, 16, AppFonts.regularFont),
  //     duration: const Duration(seconds: 3),
  //     backgroundColor: AppColorFile.blackColor,
  //   );
  //   final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
  //       GlobalKey<ScaffoldMessengerState>();
  //   scaffoldMessengerKey.currentState?.showSnackBar(snackBar);
  // }

  String getLikePhotosUrl({int? page}) {
    reelEndPoint = "${RequestParam.userId}=$userId&${RequestParam.page}=${page ?? 1}";
    return ApiBaseUrls.getLikePhotos + reelEndPoint;
  }

  String getLikeVideosUrl({int? page}) {
    reelEndPoint = "${RequestParam.userId}=$userId&${RequestParam.page}=${page ?? 1}";
    log("user id : ${userId}");
    return ApiBaseUrls.getLikeVideos + reelEndPoint;
  }

  Widget buildContainerBg({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.7),
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: child,
    );
  }

  Widget buildShimmer({required Widget child}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.withOpacity(0.8),
      highlightColor: Colors.white.withOpacity(0.8),
      period: const Duration(milliseconds: 1200),
      direction: ShimmerDirection.ltr,
      child: child,
    );
  }

  static Widget refreshIndicator({required RefreshCallback onRefresh, required StatelessWidget child}) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      color: AppColorFile.blackColor,
      child: child,
    );
  }
}
