import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shiv_status_video/utils/common.dart';

class DownloadPhotosVideosShimmerView extends StatelessWidget {
  const DownloadPhotosVideosShimmerView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Common().buildShimmer(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 20.w,
                  width: 80.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(3.r),
                  ),
                ),
                Container(
                  height: 20.w,
                  width: 60.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(3.r),
                  ),
                )
              ],
            ),
            10.verticalSpace,
            GridView.extent(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              maxCrossAxisExtent: 200.w,
              crossAxisSpacing: 16.w,
              mainAxisSpacing: 16.w,
              childAspectRatio: 0.8,
              children: List.generate(
                4,
                (index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                  );
                },
              ),
            ),
            16.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 20.w,
                  width: 80.w,
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(3.r)),
                ),
                Container(
                  height: 20.w,
                  width: 60.w,
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(3.r)),
                )
              ],
            ),
            10.verticalSpace,
            GridView.extent(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              maxCrossAxisExtent: 200.w,
              crossAxisSpacing: 18.w,
              mainAxisSpacing: 18.h,
              childAspectRatio: 0.8,
              children: List.generate(
                2,
                (index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
