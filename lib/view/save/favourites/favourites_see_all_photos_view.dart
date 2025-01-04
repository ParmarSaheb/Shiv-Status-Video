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
import 'package:shiv_status_video/view/save/favourites/favourites_see_all_photo_shimmer_view.dart';
import 'package:shiv_status_video/view_model/save/save_controller.dart';

class FavouritesSeeAllPhotosView extends StatelessWidget {
  const FavouritesSeeAllPhotosView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColorFile.blackColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: CustomAppBar(
                  title: StringFile.shivVideoStatus(context),
                  onTap: () {
                    Navigator.pop(context);
                  },
                  titleFontSize: 24.sp,
                  fontFamily: AppFonts.akayaFonts,
                  leadingIcon: AppAssets.mahadevBackIcon,
                  leadingIconHeight: 38.w,
                  leadingIconWidth: 38.w,
                  centerTitle: false,
                  reportIcon: true,
                ),
              ),
              Padding(
                  padding: EdgeInsets.all(2.0.w),
                  child: Consumer<SaveController>(
                    builder: (context, saveController, child) {
                      final mahadevPhotos = saveController.getLikePhotosData
                          .where((photo) =>
                              photo.categories != null &&
                              photo.categories!.any((category) => category.name == 'Mahadev'))
                          .toList();

                      return NotificationListener<ScrollNotification>(
                        onNotification: (ScrollNotification notification) {
                          if (notification is ScrollEndNotification &&
                              notification.metrics.pixels == notification.metrics.maxScrollExtent) {
                            saveController.paginationFetchLikePhotos();
                          }
                          return false;
                        },
                        child: saveController.isLoading
                            // child: mahadevPhotos.isEmpty
                            ? const FavouritesSeeAllPhotoShimmerView()
                            : GridView.builder(
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisSpacing: 15.w,
                                    mainAxisSpacing: 15.w,
                                    childAspectRatio: 0.9,
                                    crossAxisCount: 2),
                                padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                                shrinkWrap: true,
                                itemCount: mahadevPhotos.length,
                                // itemCount: saveController.getLikePhotosData.length,
                                itemBuilder: (context, int index) {
                                  // final subCategoryData = saveController.getLikePhotosData[index];
                                  final subCategoryData = mahadevPhotos[index];

                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(context, AppRoutes.favouritesPhotosReels,
                                          arguments: index);
                                    },
                                    child: Common().buildContainerBg(
                                      child: ClipRRect(
                                          borderRadius: BorderRadius.circular(15.r),
                                          child: CustomImageWidget(
                                            imageUrl: subCategoryData.thumbnail?.isNotEmpty == true
                                                ? subCategoryData.thumbnail
                                                : subCategoryData.contentUrl,
                                            height: double.infinity,
                                            width: double.infinity,
                                          )),
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
    );
  }
}
