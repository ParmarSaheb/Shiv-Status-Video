import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shiv_status_video/remote/model/get_darshan_photo_response.dart';
import 'package:shiv_status_video/utils/app_assets.dart';
import 'package:shiv_status_video/utils/app_color_file.dart';
import 'package:shiv_status_video/utils/app_fonts.dart';
import 'package:shiv_status_video/utils/string_file.dart';
import 'package:shiv_status_video/view/custom_view/custom_appbar.dart';
import 'package:shiv_status_video/view/custom_view/custom_page_view.dart';
import 'package:shiv_status_video/view/custom_view/custom_photo_reels_player.dart';
import 'package:shiv_status_video/view_model/darshan/darshan_controller.dart';

class DarshanCategoryPhotosReel extends StatelessWidget {
  final int index;
  final bool isDarshanLike;

  const DarshanCategoryPhotosReel({super.key, required this.index, required this.isDarshanLike});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorFile.blackColor,
      body: Consumer<DarshanController>(
        builder: (context, darshanController, child) {
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: CustomAppBar(
                  title: StringFile.posts(context),
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
              Expanded(child: _buildPage(darshanController.subCategoryDarshanPhotosList)),
            ],
          );
        },
      ),
    );
  }

  Widget _buildPage(List<GetDarshanPhotos> reels) {
    return Consumer<DarshanController>(
      builder: (context, darshanController, child) => CustomPageView(
        reels: reels,
        isMuted: false,
        initialIndex: index,
        onPageChanged: (pageIndex) {
          darshanController.photosCurrentIndex = pageIndex;
        },
        fetchMoreItems: () {
          darshanController.loadMorePageNationPhotos();
        },
        itemBuilder: (context, index) {
          return CustomPhotosReelsPlayer(
            photos: reels[index].contentUrl!,
            reel: reels[index],
            aspectRatio: 16.sp / 9.sp,
            likeCount: reels[index].likeCount,
            isDarshanLike: isDarshanLike,
          );
        },
      ),
    );
  }
}
