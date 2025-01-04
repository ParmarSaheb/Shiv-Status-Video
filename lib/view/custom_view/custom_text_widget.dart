import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextWidget extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;
  final String fontFamily;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? textOverflow;

  const CustomTextWidget(
    this.text,
    this.color,
    this.fontSize,
    this.fontFamily, {
    this.textAlign,
    this.maxLines,
    this.textOverflow,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      textAlign: textAlign,
      style: TextStyle(
        color: color,
        fontSize: fontSize.sp,
        fontFamily: fontFamily,
        overflow: textOverflow,
      ),
    );
  }
}
