import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shiv_status_video/utils/app_color_file.dart';
import 'package:shiv_status_video/utils/common.dart';
import 'package:shiv_status_video/view/custom_view/combine_video_reels.dart';
import 'package:shiv_status_video/view/custom_view/custom_image_widget.dart';
import 'package:shiv_status_video/view/home/home_shimmer_view.dart';
import 'package:shiv_status_video/view_model/home/home_controller.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorFile.blackColor,
      body: Consumer<HomeController>(
        builder: (context, homeController, child) {
          return NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification notification) {
              if (notification is ScrollEndNotification &&
                  notification.metrics.pixels == notification.metrics.maxScrollExtent) {
                homeController.pageNationReels();
                homeController.isLoadingMore = true;
              }
              return true;
            },
            child: Common.refreshIndicator(
              onRefresh: () async {
                await homeController.refreshIndicators();
              },
              child: homeController.getReelsListData.isEmpty
                  ? const HomeShimmerView()
                  : GridView.extent(
                      padding: EdgeInsets.zero,
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 1.1 / 2,
                      crossAxisSpacing: 16.0,
                      mainAxisSpacing: 16.0,
                      children: List.generate(
                          homeController.isLoadingMore
                              ? homeController.getReelsListData.length + 1
                              : homeController.getReelsListData.length, (innerIndex) {
                        if (innerIndex < homeController.getReelsListData.length) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    homeController.isMuted = false;
                                    return CombinedCategoryVideoReel(index: innerIndex, isDarshan: false);
                                  },
                                ),
                              );
                            },
                            child: Common().buildContainerBg(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15.r),
                                child: CustomImageWidget(
                                  imageUrl: homeController.getReelsListData[innerIndex].thumbnail ?? "",
                                    height: double.infinity,
                                    width: double.infinity,
                                ),
                              ),
                            ),
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(color: AppColorFile.mahadevThemeColor),
                          );
                        }
                      }),
                    ),
            ),
          );
        },
      ),
    );
  }
}
