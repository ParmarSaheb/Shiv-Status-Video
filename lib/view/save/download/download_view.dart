import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shiv_status_video/utils/app_assets.dart';
import 'package:shiv_status_video/utils/string_file.dart';
import 'package:shiv_status_video/view/custom_view/custom_title_with_action.dart';
import 'package:shiv_status_video/view/save/download/download_photos_videos_shimmer_view.dart';
import 'package:shiv_status_video/view_model/save/save_controller.dart';
import 'download_photos_videos_view.dart';
import 'download_see_all_photos_videos_view.dart';

class DownloadView extends StatelessWidget {
  const DownloadView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 6.0.r),
      child: Consumer<SaveController>(
        builder: (context, saveController, child) {
          final downloadedImageList = saveController.downloadedImageList.reversed.toList();
          final thumbnailImageList = saveController.thumbnailImageList.reversed.toList();

          if (saveController.isLoading) {
            return const DownloadPhotosVideosShimmerView();
          }

          if (downloadedImageList.isEmpty && thumbnailImageList.isEmpty) {
            return Center(
              child: Lottie.asset(
                AppAssets.lottieNoData,
                fit: BoxFit.cover,
              ),
            );
          } else {
            return ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              children: [
                if (downloadedImageList.isNotEmpty) ...[
                  CustomTitleWithAction(
                    title: StringFile.savePhotos(context),
                    onActionPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return DownloadSeeAllPhotosVideosView(
                              isPhotos: true,
                              thumbnailList: thumbnailImageList,
                              downloadedList: downloadedImageList,
                              isLoading: saveController.isLoading);
                        },
                      ));
                      //   Navigator.pushNamed(context, AppRoutes.downloadSeeAllPhotosVideosView,arguments: {
                      //     true,
                      //     thumbnailImageList,
                      //     downloadedImageList
                      //   });
                    },
                  ),
                  DownloadPhotosVideosView(
                    isPhotos: true,
                    thumbnailList: thumbnailImageList,
                    downloadedList: downloadedImageList,
                  ),
                ],
                if (thumbnailImageList.isNotEmpty) ...[
                  CustomTitleWithAction(
                    title: StringFile.saveVideos(context),
                    onActionPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return DownloadSeeAllPhotosVideosView(
                              isPhotos: false,
                              thumbnailList: thumbnailImageList,
                              downloadedList: downloadedImageList,
                              isLoading: saveController.isLoading);
                        },
                      ));
                    },
                  ),
                  DownloadPhotosVideosView(
                    isPhotos: false,
                    thumbnailList: thumbnailImageList,
                    downloadedList: downloadedImageList,
                  ),
                ],
              ],
            );
          }
        },
      ),
    );
  }
}
