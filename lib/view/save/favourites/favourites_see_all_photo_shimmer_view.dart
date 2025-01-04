import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shiv_status_video/utils/common.dart';

class FavouritesSeeAllPhotoShimmerView extends StatelessWidget {
  const FavouritesSeeAllPhotoShimmerView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Common().buildShimmer(
      child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 15.w, mainAxisSpacing: 15.w, childAspectRatio: 0.9, crossAxisCount: 2),
          padding: EdgeInsets.symmetric(horizontal: 8.0.w),
          shrinkWrap: true,
          itemCount: 6,
          itemBuilder: (context, int index) {
            return Common().buildContainerBg(
                child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(15.r),
              ),
            ));
          }),
    );
  }
}
