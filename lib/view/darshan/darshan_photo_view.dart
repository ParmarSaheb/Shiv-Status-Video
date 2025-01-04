import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shiv_status_video/utils/app_color_file.dart';
import 'package:shiv_status_video/utils/common.dart';
import 'package:shiv_status_video/view/darshan/darshan_category_photos_reel.dart';
import 'package:shiv_status_video/view/darshan/darshan_photo_shimmer_view.dart';
import 'package:shiv_status_video/view_model/darshan/darshan_controller.dart';
import 'package:shiv_status_video/view_model/home/home_controller.dart';
import 'darshan_image_view.dart';

class DarshanPhotoView extends StatelessWidget {
  const DarshanPhotoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DarshanController>(
      builder: (context, darshanController, child) {
        return NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification notification) {
            if (notification is ScrollEndNotification &&
                notification.metrics.pixels == notification.metrics.maxScrollExtent) {
              darshanController.loadMorePageNationPhotos();
              darshanController.isLoadingMore = true;
            }
            return true;
          },
          child: Common.refreshIndicator(
            onRefresh: () async {
              await darshanController.fetchDarshanVideosSubCategoryFromApi(
                  subCategories: darshanController.subCategoryId, page: 1);
            },
            child: darshanController.subCategoryDarshanPhotosList.isEmpty
                ? const DarshanPhotoShimmerView()
                : GridView.builder(
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 1.1 / 2,
                      crossAxisSpacing: 10.h,
                      mainAxisSpacing: 10.w,
                    ),
                    padding: EdgeInsets.fromLTRB(0.w, 0.w, 5.w, 0.w),
                    shrinkWrap: true,
                    itemCount: darshanController.isLoadingMore
                        ? darshanController.subCategoryDarshanPhotosList.length + 1
                        : darshanController.subCategoryDarshanPhotosList.length,
                    itemBuilder: (context, int index) {
                      if (index < darshanController.subCategoryDarshanPhotosList.length) {
                        final subCategoryData = darshanController.subCategoryDarshanPhotosList[index];
                        return GestureDetector(
                          onTap: () => Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return DarshanCategoryPhotosReel(
                                index: index,
                                isDarshanLike: true,
                              );
                            },
                          )),
                          //     Navigator.pushNamed(context,
                          //   AppRoutes.darshanCategoryPhotosReel, arguments: index,
                          // ),
                          child: Common().buildContainerBg(
                            child: DetailImageView(
                              image: subCategoryData.contentUrl.toString(),
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
    return homeController.googleRewardedAd(
        onAdShown: () => homeController.downloadAndSaveVideo(
            url: subCategoryData.contentUrl.toString(),
            fileName: subCategoryData.contentUrl.toString(),
            isShare: false,
            isWhatsAppShare: false,
            isDownloadOnly: true,
            context: context),
    );
  }

  quickShare(BuildContext context, subCategoryData) {
    final homeController = Provider.of<HomeController>(context, listen: false);
    return homeController.googleRewardedAd(
      onAdShown: () => homeController.downloadAndSaveVideo(
          url: subCategoryData.contentUrl.toString(),
          fileName: subCategoryData.contentUrl.toString(),
          isShare: true,
          isWhatsAppShare: false,
          isDownloadOnly: false,
          context: context),
    );
  }
}
