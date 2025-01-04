import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shiv_status_video/utils/app_assets.dart';
import 'package:shiv_status_video/utils/app_color_file.dart';
import 'package:shiv_status_video/utils/app_fonts.dart';
import 'package:shiv_status_video/utils/string_file.dart';
import 'package:shiv_status_video/view/custom_view/custom_appbar.dart';
import 'package:shiv_status_video/view/custom_view/custom_page_view.dart';
import 'package:shiv_status_video/view/custom_view/custom_photo_reels_player.dart';
import 'package:shiv_status_video/view_model/save/save_controller.dart';

class FavouritesPhotosReels extends StatelessWidget {
  final int index;
  final bool isDarshanLike;

  const FavouritesPhotosReels({super.key, required this.index, required this.isDarshanLike});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColorFile.blackColor,
        body: Consumer<SaveController>(
          builder: (context, saveController, child) {
            // final List<dynamic> reels = saveController.getLikePhotosData;
            final List<dynamic> mahadevReels = saveController.getLikePhotosData.where((reel) {
              return reel.categories != null &&
                  reel.categories!.any((category) => category.name == 'Mahadev');
            }).toList();

            return Container(
              color: AppColorFile.blackColor,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: CustomAppBar(title: StringFile.photos(context),
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
                  Expanded(
                      child: CustomPageView(
                        reels: mahadevReels,
                        isMuted: false,
                        initialIndex: index,
                        onPageChanged: (pageIndex) {
                          saveController.currentIndexPhotos = pageIndex;
                        },
                        fetchMoreItems: () {
                          // saveController.getLikePhotosData;
                          saveController.paginationFetchLikePhotos();
                        },
                        itemBuilder: (context, index) {
                          return CustomPhotosReelsPlayer(
                            photos: mahadevReels[index].contentUrl!,
                            reel: mahadevReels[index],
                            aspectRatio: 16.sp / 9.sp,
                            likeCount: saveController.getLikePhotosData[index].likeCount,
                            isDarshanLike: isDarshanLike,
                          );
                        },
                      )),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
