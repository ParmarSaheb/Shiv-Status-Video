import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shiv_status_video/utils/app_color_file.dart';
import 'package:shiv_status_video/utils/common.dart';

class HomeShimmerView extends StatelessWidget {
  const HomeShimmerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColorFile.blackColor,
        body: Common().buildShimmer(
          child: GridView.extent(
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            maxCrossAxisExtent: 200,
            childAspectRatio: 1.1 / 2,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            children: List.generate(4, (innerIndex) {
              return Common().buildContainerBg(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.r),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                  ),
                ),
              );
            }),
          ),
        ));
  }
}
