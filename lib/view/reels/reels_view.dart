import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shiv_status_video/remote/model/get_reels_model.dart';
import 'package:shiv_status_video/utils/app_color_file.dart';
import 'package:shiv_status_video/view/custom_view/custom_report_widget.dart';
import 'package:shiv_status_video/view/custom_view/custom_video_player.dart';
import 'package:shiv_status_video/view_model/home/home_controller.dart';
import 'package:shiv_status_video/view_model/reels/reels_controller.dart';

class ReelsView extends StatelessWidget {
  const ReelsView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: AppColorFile.blackColor,
          body: Stack(
            children: [
              Consumer<ReelsController>(
                builder: (context, reelsController, child) {
                  return _buildPage(reelsController.reelsList, reelsController.isMuted, context);
                },
              ),
              Positioned(
                top: 0.h,
                right: 10.w,
                bottom: 576.h,
                child: const CustomReportWidget(),
              )
            ],
          )),
    );
  }

  Widget _buildPage(List<GetReelsData> reels, bool isMuted, BuildContext context) {
    final homeController = Provider.of<HomeController>(context);
    return Consumer<ReelsController>(
      builder: (context, reelsController, child) => NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification notification) {
          if (notification is ScrollEndNotification &&
              notification.metrics.pixels == notification.metrics.maxScrollExtent) {
            reelsController.loadMoreReels();
          }
          return true;
        },
        child: PageView.builder(
          scrollDirection: Axis.vertical,
          itemCount: reels.length,
          onPageChanged: (index) {
            reelsController.currentIndex = index;
          },
          itemBuilder: (context, index) {
            debugPrint(reels[index].toString());
            debugPrint(reelsController.currentIndex.toString());
            log(reels[index].type!);
            homeController.isMuted = false;
            return CustomVidPlayer(
              thumbnailImage: reels[index].thumbnail!,
              videoPath: reels[index].contentUrl!,
              aspectRatio: 9.sp / 16.sp,
              soundMuteAction: isMuted,
              reelsData: reels[index],
              likCount: homeController.likeCount,
            );
          },
        ),
      ),
    );
  }
}
