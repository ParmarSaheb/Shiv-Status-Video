import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class CustomGFRadioWidget extends StatelessWidget {
  final double size;
  final int value;
  final int groupValue;
  final ValueChanged<int> onChanged;
  final Color activeBgColor;
  final Color inactiveBgColor;
  final Color inactiveBorderColor;
  final Color activeBorderColor;
  final Color radioColor;
  final bool? validation;

  const CustomGFRadioWidget(
    this.activeBgColor,
    this.inactiveBgColor,
    this.inactiveBorderColor,
    this.activeBorderColor,
    this.radioColor, {
    super.key,
    this.size = GFSize.SMALL,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.validation,
  });

  @override
  Widget build(BuildContext context) {
    return GFRadio(
      size: size,
      value: value,
      groupValue: groupValue,
      onChanged: (newValue) {
        onChanged(newValue);
      },
      inactiveIcon: null,
      activeBgColor: activeBgColor,
      inactiveBgColor: inactiveBgColor,
      inactiveBorderColor: inactiveBorderColor,
      activeBorderColor: activeBorderColor,
      radioColor: radioColor,
    );
  }
}
