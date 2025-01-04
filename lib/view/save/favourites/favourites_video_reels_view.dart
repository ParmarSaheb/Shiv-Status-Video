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

class FavouritesVideoReelsView extends StatelessWidget {
  final int index;

  const FavouritesVideoReelsView({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColorFile.blackColor,
        body: Consumer<SaveController>(
          builder: (context, saveController, child) {
            final mahadevReels = saveController.getLikeVideosData
                .where((video) =>
                    video.categories != null &&
                    video.categories!.any((category) => category.name == 'Mahadev'))
                .toList();

            return Container(
              color: AppColorFile.blackColor,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: CustomAppBar(
                      title: StringFile.reels(context),
                      onTap: () {
                        Navigator.pop(context);
                      },
                      titleFontSize: 15.sp,
                      fontFamily: AppFonts.regularFont,
                      leadingIcon: AppAssets.backArrowIcon,
                      leadingIconHeight: 16.h,
                      leadingIconWidth: 22.w,
                      centerTitle: false,
                      reportIcon: true,
                    ),
                  ),
                  10.verticalSpace,
                  Expanded(child: _buildPage(mahadevReels, saveController.isMuted))
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildPage(List<dynamic> reels, bool isMuted) {
    return Consumer<SaveController>(
      builder: (context, saveController, child) {
        return CustomPageView(
          reels: reels,
          isMuted: isMuted,
          initialIndex: index,
          fetchMoreItems: () {
            saveController.paginationFetchLikeVideos();
          },
          onPageChanged: (pageIndex) {
            saveController.currentIndexVideos = index;
          },
          itemBuilder: (context, index) {
            return CustomVidPlayer(
              aspectRatio: 9.sp / 16.sp,
              videoPath: reels[index].contentUrl ?? reels[index],
              thumbnailImage: reels[index].thumbnail ?? saveController.thumbnailImageList[index],
              soundMuteAction: isMuted,
              reelsData: reels[index],
              isDownloaded: false,
            );
          },
        );
      },
    );
  }
}
