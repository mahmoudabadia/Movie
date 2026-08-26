import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';

typedef OnValidator = String? Function(String?)?;

class CustomTextField extends StatelessWidget {
  final double? redius;
  final Color? borderColor;
  final String? hintText;
  final String? labelText;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final Color? fillColor;
  final bool? fill;
  final TextInputType? keyboardType;
  final bool obscureText;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final int? maxLines;
  final OnValidator? validator;
  final TextStyle? textStyle;

  const CustomTextField({
    super.key,
    this.redius,
    this.borderColor,
    this.hintText,
    this.labelText,
    this.hintStyle,
    this.labelStyle,
    this.fillColor,
    this.fill,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLines = 1,
    this.controller,
    this.onChanged,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: textStyle,
      decoration: InputDecoration(
        filled: fill ?? true,
        fillColor: fillColor ?? AppColors.grayColor,
        enabledBorder: builtDecorationItem(
          redius: redius ?? 16,
          borderColor: borderColor ?? AppColors.whiteColor,
        ),
        focusedBorder: builtDecorationItem(
          redius: redius ?? 16,
          borderColor: AppColors.whiteColor,
        ),
        errorBorder: builtDecorationItem(
          redius: redius ?? 16,
          borderColor: AppColors.redColor,
        ),
        focusedErrorBorder: builtDecorationItem(
          redius: redius ?? 16,
          borderColor: AppColors.redColor,
        ),
        hintText: hintText,
        hintStyle: hintStyle,
        labelText: labelText,
        labelStyle: labelStyle,

        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
      maxLines: maxLines,
      controller: controller,
      onChanged: onChanged,
      validator: validator,
      keyboardType: keyboardType,
      obscureText: obscureText,
      cursorColor: AppColors.whiteColor,
    );
  }

  OutlineInputBorder builtDecorationItem({
    required double redius,
    required Color borderColor,
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(redius),
      borderSide: BorderSide(width: 2, color: borderColor),
    );
  }
}
