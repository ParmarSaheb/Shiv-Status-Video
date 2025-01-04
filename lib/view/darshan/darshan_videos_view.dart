import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shiv_status_video/remote/api/request_params_api.dart';
import 'package:shiv_status_video/routes.dart';
import 'package:shiv_status_video/utils/app_color_file.dart';
import 'package:shiv_status_video/utils/common.dart';
import 'package:shiv_status_video/view/darshan/darshan_videos_shimmer_view.dart';
import 'package:shiv_status_video/view_model/darshan/darshan_controller.dart';
import 'package:shiv_status_video/view_model/home/home_controller.dart';
import 'darshan_image_view.dart';

class DarshanVideosView extends StatelessWidget {
  const DarshanVideosView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DarshanController>(
      builder: (context, darshanController, child) {
        return NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification notification) {
            if (notification is ScrollEndNotification &&
                notification.metrics.pixels == notification.metrics.maxScrollExtent) {
              darshanController.loadMorePageNationVideos();
              darshanController.isLoadingMore = true;
            }
            return true;
          },
          child: Common.refreshIndicator(
            onRefresh: () async {
              await darshanController.fetchDarshanVideosSubCategoryFromApi(
                  subCategories: darshanController.subCategoryId, page: 1);
            },
            child: darshanController.subCategoryDarshanVideosList.isEmpty
                ? const DarshanVideosShimmerView()
                : GridView.builder(
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 1.1 / 2,
                      crossAxisSpacing: 10.h,
                      mainAxisSpacing: 10.w,
                    ),
                    padding: EdgeInsets.fromLTRB(5.w, 0.w, 0.w, 0.w),
                    shrinkWrap: true,
                    itemCount: darshanController.isLoadingMore
                        ? darshanController.subCategoryDarshanVideosList.length + 1
                        : darshanController.subCategoryDarshanVideosList.length,
                    itemBuilder: (context, int index) {
                      if (index < darshanController.subCategoryDarshanVideosList.length) {
                        final subCategoryData = darshanController.subCategoryDarshanVideosList[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.combinedCategoryVideoReelView,
                              arguments: {
                                RequestParam.index: index,
                                RequestParam.isDarshan: true,
                              },
                            );
                          },
                          child: Common().buildContainerBg(
                            child: DetailImageView(
                              image: subCategoryData.thumbnail.toString(),
                              imageName: '',
                              isShowing: false,
                              share: () => quickShare(context, subCategoryData),
                              download: () => quickDownload(context, subCategoryData),
                            ),
                          ),
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: AppColorFile.mahadevThemeColor,
                          ),
                        );
                      }
                    },
                  ),
          ),
        );
      },
    );
  }

  quickDownload(BuildContext context, subCategoryData) {
    final homeController = Provider.of<HomeController>(context, listen: false);
    File file = File(subCategoryData.contentUrl.toString());
    return homeController.downloadAndSaveVideo(
        url: subCategoryData.contentUrl.toString(),
        fileName: file.path,
        isShare: false,
        isWhatsAppShare: false,
        isDownloadOnly: true,
        context: context);
  }

  quickShare(BuildContext context, subCategoryData) {
    final homeController = Provider.of<HomeController>(context, listen: false);
    File file = File(subCategoryData.contentUrl.toString());
    return homeController.downloadAndSaveVideo(
        url: subCategoryData.contentUrl.toString(),
        fileName: file.path,
        isShare: true,
        isWhatsAppShare: false,
        isDownloadOnly: false,
        context: context);
  }
}
