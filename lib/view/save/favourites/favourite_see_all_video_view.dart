import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shiv_status_video/routes.dart';
import 'package:shiv_status_video/utils/app_assets.dart';
import 'package:shiv_status_video/utils/app_color_file.dart';
import 'package:shiv_status_video/utils/app_fonts.dart';
import 'package:shiv_status_video/utils/common.dart';
import 'package:shiv_status_video/utils/string_file.dart';
import 'package:shiv_status_video/view/custom_view/custom_appbar.dart';
import 'package:shiv_status_video/view/custom_view/custom_image_widget.dart';
import 'package:shiv_status_video/view/save/favourites/favourite_see_all_video_shimmer_view.dart';
import 'package:shiv_status_video/view_model/save/save_controller.dart';

class FavouriteSeeAllVideoView extends StatelessWidget {
  const FavouriteSeeAllVideoView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColorFile.blackColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Column(
              children: [
                CustomAppBar(
                    title: StringFile.shivVideoStatus(context),
                    onTap: () {
                      Navigator.pop(context);
                    },
                    titleFontSize: 24.sp,
                    fontFamily: AppFonts.akayaFonts,
                    leadingIcon: AppAssets.mahadevBackIcon,
                    leadingIconHeight: 38.w,
                    leadingIconWidth: 38.w),
                Padding(
                    padding: EdgeInsets.only(top: 2.w),
                    child: Consumer<SaveController>(
                      builder: (context, saveController, child) {
                        final mahadevVideos = saveController.getLikeVideosData
                            .where((video) =>
                                video.categories != null &&
                                video.categories!.any((category) => category.name == 'Mahadev'))
                            .toList();

                        return NotificationListener<ScrollNotification>(
                          onNotification: (ScrollNotification notification) {
                            if (notification is ScrollEndNotification &&
                                notification.metrics.pixels == notification.metrics.maxScrollExtent) {
                              saveController.paginationFetchLikeVideos();
                            }
                            return false;
                          },
                          child: saveController.getLikePhotosData.isNotEmpty
                              // mahadevVideos.isEmpty
                              ? const FavouriteSeeAllVideoShimmerView()
                              : GridView.builder(
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisSpacing: 15.w,
                                      mainAxisSpacing: 15.w,
                                      childAspectRatio: 0.9,
                                      crossAxisCount: 2),
                                  // padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                                  shrinkWrap: true,
                                  itemCount: mahadevVideos.length,
                                  // itemCount: saveController.getLikeVideosData.length,
                                  itemBuilder: (context, int index) {
                                    // final subCategoryData = saveController.getLikeVideosData[index];
                                    final subCategoryData = mahadevVideos[index];
                                    final imageUrl = subCategoryData.thumbnail?.isNotEmpty == true
                                        ? subCategoryData.thumbnail
                                        : subCategoryData.contentUrl;

                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(context, AppRoutes.favouritesVideoReelsView,
                                            arguments: index);
                                      },
                                      child: Common().buildContainerBg(
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(15.r),
                                          child: CustomImageWidget(
                                            imageUrl: imageUrl!,
                                            height: double.infinity,
                                            width: double.infinity,
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                        );
                      },
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
