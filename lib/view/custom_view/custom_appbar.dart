import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shiv_status_video/utils/app_color_file.dart';
import 'package:shiv_status_video/view/custom_view/custom_image_widget.dart';
import 'package:shiv_status_video/view/custom_view/custom_text_widget.dart';

import 'custom_report_widget.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final double titleFontSize;
  final String fontFamily;
  final String leadingIcon;
  final double leadingIconHeight;
  final double leadingIconWidth;
  final bool centerTitle;
  final bool reportIcon;
  final void Function() onTap;
  final EdgeInsets? padding;

  const CustomAppBar({
    super.key,
    required this.title,
    required this.onTap,
    required this.titleFontSize,
    required this.fontFamily,
    required this.leadingIcon,
    required this.leadingIconHeight,
    required this.leadingIconWidth,
    this.centerTitle = true,
    this.reportIcon = false,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(top: 4.h),
        child: Row(
          children: [
            GestureDetector(
              onTap: onTap,
              child: CustomImageWidget(
                assetPath: leadingIcon,
                height: leadingIconHeight,
                width: leadingIconWidth,
              ),
            ),
            if (!centerTitle) SizedBox(width: 20.w),
            Expanded(
              child: Align(
                alignment: centerTitle ? Alignment.center : Alignment.centerLeft,
                child: CustomTextWidget(
                  title,
                  AppColorFile.whiteColor,
                  titleFontSize,
                  fontFamily,
                  maxLines: 1,
                  textOverflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            if (reportIcon)
              const Align(
                alignment: Alignment.topRight,
                child: CustomReportWidget(),
              )
          ],
        ),
      ),
    );
  }
}

// class CustomAppBar extends StatelessWidget {
//   final void Function() onTap;
//   final void Function()? onPressed;
//   final String icon;
//   final String title;
//   final bool actionButton;
//   final bool reportButton;
//   final bool centerTitle;
//   final String fontFamily;
//   final double fontSize;
//   final double iconHeight;
//   final double iconWidth;
//   final EdgeInsetsGeometry padding;
//   final EdgeInsetsGeometry? margin;
//   final double? height;
//
//   const CustomAppBar({
//     super.key,
//     required this.onTap,
//     required this.icon,
//     required this.title,
//     required this.actionButton,
//     required this.centerTitle,
//     required this.fontFamily,
//     required this.fontSize,
//     required this.reportButton,
//     required this.iconWidth,
//     required this.iconHeight,
//     this.padding = const EdgeInsets.fromLTRB(0, 0, 0, 0),
//     this.onPressed,
//     this.margin,
//     this.height,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: padding,
//       height: height ?? 70.h,
//       margin: margin,
//       decoration: BoxDecoration(
//         color: AppColorFile.blackColor,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             blurRadius: 4.0.r,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: SafeArea(
//         child: Stack(
//           children: [
//             Align(
//               alignment: Alignment.centerLeft,
//               child: GestureDetector(onTap: onTap, child: _iconWidget(icon)),
//             ),
//             Align(
//               alignment: centerTitle ? Alignment.center : Alignment.centerLeft,
//               child: Padding(
//                 padding: EdgeInsets.symmetric(horizontal: centerTitle ? 0 : 40.0.w),
//                 child: CustomTextWidget(
//                   title,
//                   AppColorFile.whiteColor,
//                   fontSize,
//                   fontFamily,
//                   textAlign: TextAlign.right,
//                   maxLines: 1,
//                   textOverflow: TextOverflow.ellipsis,
//                 ),
//               ),
//             ),
//             reportButton
//                 ? const Align(
//                     alignment: Alignment.centerRight,
//                     child: CustomReportWidget(),
//                   )
//                 : Align(
//                     alignment: Alignment.centerRight,
//                     child: actionButton
//                         ? GestureDetector(
//                             onTap: onPressed,
//                             child: Container(
//                               padding: EdgeInsets.all(12.r),
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(11.r), color: AppColorFile.mahadevThemeColor),
//                               child: CustomTextWidget(StringFile.done(context), AppColorFile.whiteColor, 16,
//                                   AppFonts.regularFont),
//                             ))
//                         : const SizedBox.shrink(),
//                   ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _iconWidget(String icon) {
//     return SizedBox(
//       height: iconHeight,
//       width: iconWidth,
//       child: CustomImageWidget(
//         assetPath: icon,
//         height: iconHeight,
//         width: iconWidth,
//       ),
//     );
//   }
// }
