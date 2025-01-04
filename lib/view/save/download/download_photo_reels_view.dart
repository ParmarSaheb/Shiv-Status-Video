import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shiv_status_video/utils/app_assets.dart';
import 'package:shiv_status_video/utils/app_color_file.dart';
import 'package:shiv_status_video/utils/app_fonts.dart';
import 'package:shiv_status_video/utils/common.dart';
import 'package:shiv_status_video/utils/string_file.dart';
import 'package:shiv_status_video/view/custom_view/custom_appbar.dart';
import 'package:shiv_status_video/view/custom_view/custom_page_view.dart';
import 'package:shiv_status_video/view_model/save/save_controller.dart';
import '../image_loader.dart';

class DownloadPhotoReelsView extends StatelessWidget {
  final int index;

  const DownloadPhotoReelsView({super.key, required this.index});

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
          Expanded(
            child: Consumer<SaveController>(
              builder: (context, saveController, child) {
                final photosDataReelsList = saveController.downloadedImageList.reversed.toList();
                return CustomPageView(
                  reels: photosDataReelsList,
                  isMuted: false,
                  initialIndex: index,
                  onPageChanged: (pageIndex) {
                    saveController.currentIndexPhotos = pageIndex;
                  },
                  itemBuilder: (context, index) {
                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        ImageLoader(imagePath: photosDataReelsList[index]),
                        Positioned(
                            bottom: 50,
                            right: 0,
                            child: Common().actionButton(photosDataReelsList[index], context)),
                      ],
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
