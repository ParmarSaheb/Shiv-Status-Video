import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomImageWidget extends StatelessWidget {
  final String imageUrl;
  final String assetPath;
  final bool isSvg;
  final double height;
  final double width;
  final BoxFit fit;
  final Color? color;

  const CustomImageWidget({
    super.key,
    this.imageUrl = '',
    this.assetPath = '',
    this.isSvg = false,
    required this.height,
    required this.width,
    this.fit = BoxFit.cover,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    if (isSvg) {
      return SvgPicture.asset(
        assetPath,
        height: height,
        width: width,
        fit: fit,
        colorFilter: color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
      );
    } else if (imageUrl.isNotEmpty) {
      return Image.network(
        imageUrl,
        height: height,
        width: width,
        fit: fit,
        errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
      );
    } else {
      return Image.asset(
        assetPath,
        height: height,
        width: width,
        fit: fit,
        errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
      );
    }
  }
}
