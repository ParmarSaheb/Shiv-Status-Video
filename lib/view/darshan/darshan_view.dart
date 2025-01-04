import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shiv_status_video/routes.dart';
import 'package:shiv_status_video/utils/app_color_file.dart';
import 'package:shiv_status_video/utils/common.dart';
import 'package:shiv_status_video/view/darshan/darshan_shimmer_view.dart';
import 'package:shiv_status_video/view_model/darshan/darshan_controller.dart';
import 'darshan_image_view.dart';

class DarshanView extends StatelessWidget {
  const DarshanView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorFile.blackColor,
      body: Consumer<DarshanController>(
        builder: (context, darshanController, child) {
          return darshanController.subCategoryResponseDataList.isEmpty
              ? const DarshanShimmerView()
              : GridView.extent(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 14.w),
                  maxCrossAxisExtent: 200.w,
                  crossAxisSpacing: 18.w,
                  mainAxisSpacing: 18.h,
                  childAspectRatio: 0.8,
                  children: List.generate(
                    darshanController.subCategoryResponseDataList.length,
                    (index) {
                      final categoryData = darshanController.subCategoryResponseDataList[index];

                      return GestureDetector(
                        onTap: () {
                          _onSubCategoryTap(context, categoryData.categoryId!, index, categoryData);
                        },
                        child: Common().buildContainerBg(
                          child: DetailImageView(
                            image: categoryData.category!.icon.toString(),
                            imageName: categoryData.name,
                            isShowing: true,
                            isLoading: darshanController.isLoading,
                          ),
                        ),
                      );
                    },
                  ),
                );
        },
      ),
    );
  }

  Future<void> _onSubCategoryTap(
      BuildContext context, String categoryId, int index, dynamic categoryData) async {
    final darshanController = Provider.of<DarshanController>(context, listen: false);
    darshanController.subCategoryId = categoryId;
    String categoryName = categoryData.name?.toString() ?? '';

    Navigator.pushNamed(
      context,
      AppRoutes.dailyDarshanSubCategoryView,
      arguments: categoryName,
    );

    await darshanController.fetchDarshanPhotosSubCategoryFromApi(subCategories: categoryId);
    await darshanController.fetchDarshanVideosSubCategoryFromApi(subCategories: categoryId);
  }
}
