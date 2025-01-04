import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shiv_status_video/utils/app_assets.dart';
import 'package:shiv_status_video/utils/app_color_file.dart';
import 'package:shiv_status_video/utils/app_fonts.dart';
import 'package:shiv_status_video/utils/string_file.dart';
import 'package:shiv_status_video/view/custom_view/custom_appbar.dart';
import 'package:shiv_status_video/view_model/darshan/darshan_controller.dart';
import 'package:shiv_status_video/view_model/home/home_controller.dart';
import 'custom_page_view.dart';
import 'custom_video_player.dart';

class CombinedCategoryVideoReel extends StatefulWidget {
  final int index;
  final bool isDarshan;

  const CombinedCategoryVideoReel({super.key, required this.index, required this.isDarshan});

  @override
  State<CombinedCategoryVideoReel> createState() => _CombinedCategoryVideoReelState();
}

class _CombinedCategoryVideoReelState extends State<CombinedCategoryVideoReel> {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder: (context, homeController, child) {
        final darshanController = Provider.of<DarshanController>(context);
        final List<dynamic> reels = widget.isDarshan
            ? darshanController.subCategoryDarshanVideosList
            : homeController.getReelsListData;
        final bool isMuted = widget.isDarshan ? homeController.isTabVideoMuted : homeController.isMuted;

        return Scaffold(
          backgroundColor: AppColorFile.blackColor,
          body: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10.w,right: 10.w),
                child: CustomAppBar(title: StringFile.reels(context),
                    onTap: () {
                      Navigator.pop(context);
                    },
                    titleFontSize: 15.sp,
                    fontFamily: AppFonts.regularFont,
                    leadingIcon: AppAssets.backArrowIcon,
                    leadingIconHeight: 15.h,
                    leadingIconWidth: 22.w,
                  centerTitle: false,
                  reportIcon: true,
                ),
              ),
              Expanded(child: _buildPage(reels.cast<dynamic>(), isMuted)),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPage(List<dynamic> reels, bool isMuted) {
    return Consumer<HomeController>(
      builder: (context, homeController, child) {
        return CustomPageView(
          reels: reels,
          isMuted: isMuted,
          initialIndex: widget.index,
          onPageChanged: (pageIndex) {
            if (widget.isDarshan) {
              homeController.photosCurrentIndex = pageIndex;
            } else {
              homeController.currentIndex = pageIndex;
            }
          },
          fetchMoreItems: () {
            if (widget.isDarshan) {
              final darshanController = Provider.of<DarshanController>(context, listen: false);
              darshanController.loadMorePageNationVideos();
            } else {
              homeController.pageNationReels();
            }
          },
          itemBuilder: (context, index) {
            return CustomVidPlayer(
              thumbnailImage: reels[index].thumbnail!,
              videoPath: reels[index].contentUrl!,
              aspectRatio: 9.sp / 16.sp,
              soundMuteAction: isMuted,
              reelsData: reels[index],
            );
          },
        );
      },
    );
  }
}
