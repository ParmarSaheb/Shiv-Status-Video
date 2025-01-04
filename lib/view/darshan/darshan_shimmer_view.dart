import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shiv_status_video/utils/app_color_file.dart';
import 'package:shiv_status_video/utils/common.dart';
class DarshanShimmerView extends StatelessWidget {
  const DarshanShimmerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorFile.blackColor,
      body: GridView.extent(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        maxCrossAxisExtent: 200.w,
        crossAxisSpacing: 18.w,
        mainAxisSpacing: 18.h,
        childAspectRatio: 0.8,
        children: List.generate(6, (index) {
          return Common().buildContainerBg(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(15.r),
              ),
              child: Stack(
                children: [
                  Common().buildShimmer(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Common().buildShimmer(
                      child: Container(
                        color: Colors.grey[300],
                        height: 30.w,
                        width: double.infinity,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
