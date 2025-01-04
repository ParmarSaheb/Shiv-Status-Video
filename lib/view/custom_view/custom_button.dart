import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color color;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadiusGeometry? borderRadius;
  final double width;
  final String? fontFamily;
  final TextAlign? textAlign;

  const CustomButton({
    super.key,
    required this.text,
    required this.color,
    this.textColor,
    this.fontSize,
    this.fontWeight,
    this.onTap,
    this.padding,
    this.margin,
    this.borderRadius,
    this.fontFamily,
    this.textAlign,
    this.width = double.infinity,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding,
        margin: margin,
        decoration: BoxDecoration(
          color: color,
          borderRadius: borderRadius,
        ),
        width: width,
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: fontSize,
            fontWeight: fontWeight,
            fontFamily: fontFamily,
          ),
          textAlign: textAlign,
        ),
      ),
    );
  }
}
