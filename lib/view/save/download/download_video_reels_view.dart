import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shiv_status_video/utils/app_assets.dart';
import 'package:shiv_status_video/utils/app_color_file.dart';
import 'package:shiv_status_video/utils/app_fonts.dart';
import 'package:shiv_status_video/utils/string_file.dart';
import 'package:shiv_status_video/view/custom_view/custom_appbar.dart';
import 'package:shiv_status_video/view/custom_view/custom_page_view.dart';
import 'package:shiv_status_video/view/custom_view/custom_video_player.dart';
import 'package:shiv_status_video/view_model/save/save_controller.dart';

class DownloadVideoReelsView extends StatelessWidget {
  final int index;

  const DownloadVideoReelsView({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorFile.blackColor,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: CustomAppBar(title: StringFile.reels(context),
                onTap: () {
                  Navigator.pop(context);
                },
                titleFontSize: 15.sp,
                fontFamily: AppFonts.regularFont,
                leadingIcon: AppAssets.backArrowIcon,
                leadingIconHeight: 16.h,
                leadingIconWidth: 22.w,
              centerTitle: false,
            ),
          ),
          10.verticalSpace,
          Expanded(child: Consumer<SaveController>(
            builder: (context, saveController, child) {
              var downloadedVideoList = saveController.downloadedVideoList.reversed.toList();
              return CustomPageView(
                reels: downloadedVideoList,
                isMuted: saveController.isMuted,
                initialIndex: index,
                onPageChanged: (pageIndex) {
                  saveController.photosCurrentIndex = pageIndex;
                },
                itemBuilder: (context, index) {
                  return CustomVidPlayer(
                    aspectRatio: 9.sp / 16.sp,
                    videoPath: downloadedVideoList[index],
                    thumbnailImage: saveController.thumbnailImageList[index],
                    soundMuteAction: saveController.isMuted,
                    reelsData: downloadedVideoList[index],
                    isDownloaded: true,
                  );
                },
              );
            },
          ))
        ],
      ),
    );
  }
}
