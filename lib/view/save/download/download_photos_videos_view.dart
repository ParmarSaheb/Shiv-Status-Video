import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shiv_status_video/routes.dart';
import 'package:shiv_status_video/view/save/download/download_video_reels_view.dart';

class DownloadPhotosVideosView extends StatelessWidget {
  final bool isPhotos;
  final List thumbnailList;
  final List downloadedList;

  const DownloadPhotosVideosView(
      {super.key, required this.isPhotos, required this.thumbnailList, required this.downloadedList});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        mainAxisExtent: 160.h,
        maxCrossAxisExtent: 200.w,
        childAspectRatio: 1.1 / 2,
        crossAxisSpacing: 10.h,
        mainAxisSpacing: 10.w,
      ),
      itemCount: isPhotos
          ? (downloadedList.length < 4 ? downloadedList.length : 4)
          : (thumbnailList.length < 4 ? thumbnailList.length : 4),
      itemBuilder: (BuildContext ctx, innerIndex) {
        return GestureDetector(
          onTap: () {
            if (isPhotos) {
              Navigator.pushNamed(context, AppRoutes.downloadPhotoReelsView, arguments: innerIndex);
            } else {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return DownloadVideoReelsView(index: innerIndex);
                },
              ));
              // Navigator.pushNamed(context, AppRoutes.downloadVideoReelsView,arguments: innerIndex);
            }
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15.r),
            child: Image.file(
              File(
                isPhotos ? downloadedList[innerIndex] : thumbnailList[innerIndex],
              ),
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }
}
