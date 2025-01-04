import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shiv_status_video/utils/app_assets.dart';
import 'package:shiv_status_video/utils/app_color_file.dart';
import 'package:shiv_status_video/utils/app_fonts.dart';
import 'package:shiv_status_video/view/custom_view/custom_text_widget.dart';

class DetailImageView extends StatelessWidget {
  const DetailImageView({
    super.key,
    required this.image,
    this.imageName,
    required this.isShowing,
    this.share,
    this.download,
    this.isLoading = false,
  });

  final bool isShowing;
  final String image;
  final String? imageName;
  final void Function()? share;
  final void Function()? download;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    double iconHeight = 25.w;
    double iconWidth = 25.w;
    return Stack(fit: StackFit.expand, children: [
      // Background image
      ClipRRect(
        borderRadius: BorderRadius.circular(15.r),
        child: Image.network(
          image,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
        ),
      ),
      // Overlay content
      isShowing
          ? Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(11.r),
                decoration: BoxDecoration(
                  color: AppColorFile.black54,
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(15.r)),
                ),
                child: CustomTextWidget(
                  imageName!,
                  AppColorFile.whiteColor,
                  AppFonts.fontSize38,
                  AppFonts.regularFont,
                  textAlign: TextAlign.center,
                ),
              ),
            )
          : Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 4.w),
                decoration: BoxDecoration(
                  color: AppColorFile.black54,
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(15.r)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                        onTap: share,
                        child: SvgPicture.asset(AppAssets.icSend, height: iconHeight, width: iconWidth)),
                    Container(
                      color: AppColorFile.greyColor.withOpacity(0.5),
                      height: iconHeight,
                      width: 1.w,
                    ),
                    InkWell(
                        onTap: download,
                        child: SvgPicture.asset(AppAssets.icDownload, height: iconHeight, width: iconWidth)),
                  ],
                ),
              ),
            ),
    ]);
  }
}
