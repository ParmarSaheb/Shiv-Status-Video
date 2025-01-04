import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shiv_status_video/routes.dart';
import 'package:shiv_status_video/utils/app_assets.dart';
import 'package:shiv_status_video/utils/string_file.dart';
import 'package:shiv_status_video/view/custom_view/custom_title_with_action.dart';
import 'package:shiv_status_video/view/save/favourites/favourites_shimmer_view.dart';
import 'package:shiv_status_video/view_model/liked_provider.dart';
import 'package:shiv_status_video/view_model/save/save_controller.dart';
import 'favourites_photos_videos_view.dart';

class FavouritesView extends StatelessWidget {
  const FavouritesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 2.0.w),
      child: Consumer<LikedProvider>(
        builder: (context, saveController, child) {
          final favouriteImageList = saveController.favImageList.reversed.toList();
          final favouriteVideoList = saveController.favVideoList.reversed.toList();

          // if (saveController.isLoading) {
          //   return const FavouritesShimmerView();
          // }

          if (favouriteImageList.isEmpty && favouriteVideoList.isEmpty) {
            return Center(
              child: Lottie.asset(
                AppAssets.lottieNoData,
                fit: BoxFit.cover,
              ),
            );
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                if (favouriteImageList.isNotEmpty) ...[
                  CustomTitleWithAction(
                    title: StringFile.likePhotos(context),
                    onActionPressed: () {
                      Navigator.pushNamed(context, AppRoutes.favouritesSeeAllPhotosView);
                    },
                  ),
                  const FavouritesPhotosVideosView(
                    isPhotos: true,
                  ),
                ],
                if (favouriteVideoList.isNotEmpty) ...[
                  CustomTitleWithAction(
                    title: StringFile.likeVideos(context),
                    onActionPressed: () {
                      Navigator.pushNamed(context, AppRoutes.favouriteSeeAllVideoView);
                    },
                  ),
                  const FavouritesPhotosVideosView(
                    isPhotos: false,
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}
