import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shiv_status_video/remote/model/get_darshan_photo_response.dart';
import 'package:shiv_status_video/remote/model/get_reels_model.dart';
import 'package:shiv_status_video/routes.dart';
import 'package:shiv_status_video/utils/common.dart';
import 'package:shiv_status_video/view/custom_view/custom_image_widget.dart';
import 'package:shiv_status_video/view/save/favourites/favourites_photos_reels.dart';
import 'package:shiv_status_video/view_model/liked_provider.dart';

class FavouritesPhotosVideosView extends StatefulWidget {
  final bool isPhotos;

  const FavouritesPhotosVideosView({super.key, required this.isPhotos});

  @override
  State<FavouritesPhotosVideosView> createState() => _FavouritesPhotosVideosViewState();
}

class _FavouritesPhotosVideosViewState extends State<FavouritesPhotosVideosView> {

  @override
  void initState() {
    super.initState();
    context.read<LikedProvider>().getFavourites(LikeType.image);
    context.read<LikedProvider>().getFavourites(LikeType.video);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LikedProvider>(
      builder: (context, saveController, child) {
        // final mediaList = isPhotos
        //     ? saveController.getLikePhotosData
        //     .where((photo) => (photo.isLiked ?? 0) == 1)
        //     .toList()
        //     : saveController.getLikeVideosData
        //     .where((video) => (video.isLiked ?? 0) == 1)
        //     .toList();

        final mediaList = widget.isPhotos
            ? saveController.favImageList
            : saveController.favVideoList;

        // final mediaList = saveController.getLikeVideosData;
        log(' like length is ======== ${mediaList.length}');
        return SizedBox(
          height: 380.w,
          child: GridView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              mainAxisExtent: 160.h,
              maxCrossAxisExtent: 200.w,
              childAspectRatio: 1.1 / 2,
              crossAxisSpacing: 10.h,
              mainAxisSpacing: 10.w,
            ),
            itemCount: mediaList.length < 4 ? mediaList.length : 4,
            itemBuilder: (BuildContext ctx, innerIndex) {
              // print(' like length is ======== ${mediaList.length}');
              return GestureDetector(
                onTap: () {
                  if (widget.isPhotos) {
                    // Navigator.pushNamed(context, AppRoutes.favouritesPhotosReels,
                    //     arguments: innerIndex);
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return FavouritesPhotosReels(index: innerIndex, isDarshanLike: true);
                      },
                    ));
                  } else {
                    Navigator.pushNamed(context, AppRoutes.favouritesVideoReelsView, arguments: innerIndex);
                  }
                },
                child: Common().buildContainerBg(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.r),
                    child: CustomImageWidget(
                        imageUrl: widget.isPhotos ? (mediaList[innerIndex] as GetDarshanPhotos).contentUrl ?? '' : (mediaList[innerIndex] as GetReelsData).thumbnail ?? '',
                      height: double.infinity,
                      width: double.infinity,),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
