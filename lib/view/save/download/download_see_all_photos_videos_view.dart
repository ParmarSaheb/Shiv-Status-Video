import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shiv_status_video/routes.dart';
import 'package:shiv_status_video/utils/app_assets.dart';
import 'package:shiv_status_video/utils/app_color_file.dart';
import 'package:shiv_status_video/utils/app_fonts.dart';
import 'package:shiv_status_video/utils/string_file.dart';
import 'package:shiv_status_video/view/custom_view/custom_appbar.dart';
import 'package:shiv_status_video/view/save/download/download_see_all_photo_video_shimmer_view.dart';
import '../image_loader.dart';

class DownloadSeeAllPhotosVideosView extends StatelessWidget {
  final bool isPhotos;
  final List thumbnailList;
  final List downloadedList;
  final bool isLoading;

  const DownloadSeeAllPhotosVideosView(
      {super.key,
      required this.isPhotos,
      required this.thumbnailList,
      required this.downloadedList,
      this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorFile.blackColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
        child: Column(
          children: [
            CustomAppBar(
                title: StringFile.shivVideoStatus(context),
                onTap: () {
                  Navigator.pop(context);
                },
                titleFontSize: 24.sp,
                fontFamily: AppFonts.akayaFonts,
                leadingIcon: AppAssets.mahadevBackIcon,
                leadingIconHeight: 38.w,
                leadingIconWidth: 38.w),
            Expanded(
                child: isLoading
                    ? const DownloadSeeAllPhotoVideoShimmerView()
                    : GridView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          mainAxisExtent: 160.w,
                          maxCrossAxisExtent: 200.w,
                          childAspectRatio: 1.1 / 2,
                          crossAxisSpacing: 10.w,
                          mainAxisSpacing: 10.w,
                        ),
                        itemCount: isPhotos ? downloadedList.length : thumbnailList.length,
                        itemBuilder: (BuildContext ctx, innerIndex) {
                          return GestureDetector(
                            onTap: () {
                              if (isPhotos) {
                                Navigator.pushNamed(context, AppRoutes.downloadPhotoReelsView,
                                    arguments: innerIndex);
                              } else {
                                Navigator.pushNamed(context, AppRoutes.downloadVideoReelsView,
                                    arguments: innerIndex);
                              }
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15.r),
                              child: ImageLoader(
                                  imagePath:
                                      isPhotos ? downloadedList[innerIndex] : thumbnailList[innerIndex]),
                            ),
                          );
                        },
                      ))
          ],
        ),
      ),
    );
  }
}
