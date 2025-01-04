import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shiv_status_video/utils/app_assets.dart';
import 'package:shiv_status_video/utils/app_color_file.dart';
import 'package:shiv_status_video/utils/common.dart';
import 'package:shiv_status_video/view/custom_view/custom_image_widget.dart';

class LanguageMenuItemShimmerView extends StatelessWidget {
  const LanguageMenuItemShimmerView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(bottom: 10.w),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 8.w, horizontal: 10.w),
            decoration: BoxDecoration(
              color: AppColorFile.shimmerBlackColor,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Row(
              children: [
                Common().buildShimmer(
                  child: Container(
                    height: 40.w,
                    width: 40.w,
                    decoration: BoxDecoration(
                        color: AppColorFile.whiteColor, borderRadius: BorderRadius.circular(20.r)),
                  ),
                ),
                18.horizontalSpace,
                Common().buildShimmer(
                  child: Container(
                    height: 26.w,
                    width: 100.w,
                    decoration: BoxDecoration(
                        color: AppColorFile.greyColor, borderRadius: BorderRadius.circular(4.r)),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class LanguageChooseShimmerView extends StatelessWidget {
  const LanguageChooseShimmerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        30.verticalSpace,
        CustomImageWidget(assetPath: AppAssets.mahadevAppLogo, height: 50.h, width: 50.w),
        15.verticalSpace,
        Common().buildShimmer(
          child: Container(
            height: 20.w,
            width: 180.w,
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(6.r)),
          ),
        ),
        24.verticalSpace,
        Expanded(
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1 / 0.7,
              crossAxisSpacing: 20.w,
              mainAxisSpacing: 20.h,
            ),
            itemCount: 6,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  color: AppColorFile.background,
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Common().buildShimmer(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 40.w,
                            width: 40.w,
                            decoration: BoxDecoration(
                                color: AppColorFile.whiteColor, borderRadius: BorderRadius.circular(20.r)),
                          ),
                          10.verticalSpace,
                          Container(
                            height: 20.w,
                            width: 100.w,
                            decoration:
                                BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(3.r)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        Container(
            height: 50.w,
            width: double.infinity,
            decoration:
                BoxDecoration(color: AppColorFile.background, borderRadius: BorderRadius.circular(5.r)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Common().buildShimmer(
                  child: Container(
                    height: 20.w,
                    width: 100.w,
                    decoration: BoxDecoration(
                        color: AppColorFile.whiteColor, borderRadius: BorderRadius.circular(5.r)),
                  ),
                )
              ],
            ))
      ],
    );
  }
}
