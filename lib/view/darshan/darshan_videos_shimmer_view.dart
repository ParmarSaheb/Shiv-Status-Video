import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shiv_status_video/utils/common.dart';

class DarshanVideosShimmerView extends StatelessWidget {
  const DarshanVideosShimmerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Common().buildShimmer(
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 1.1 / 2,
          crossAxisSpacing: 10.h,
          mainAxisSpacing: 10.w,
        ),
        padding: EdgeInsets.fromLTRB(5.w, 0.w, 0.w, 0.w),
        shrinkWrap: true,
        itemCount: 6,
        itemBuilder: (context, int index) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(15.r),
            ),
          );
        },
      ),
    );
  }
}
