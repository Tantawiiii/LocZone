import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loczone/core/extinsions/extinsions.dart';
import 'package:loczone/core/utils/app_colors.dart';


class TextFieldWidget extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final Function(String?)? validator;
  final bool? obscureText;
  final bool? enabled;
  final int? maxLines;
  final Widget? suffixIcon;
  final bool? autofocus;
  final bool? readOnly;
  final Widget? prefixIcon;
  final Color? fillColor;
  final Function()? onTap;
  const TextFieldWidget({
    super.key,
    required this.hintText,
    this.controller,
    this.keyboardType,
    this.onChanged,
    this.validator,
    this.obscureText,
    this.enabled,
    this.maxLines,
    this.suffixIcon,
    this.autofocus,
    this.prefixIcon,
    this.readOnly,
    this.fillColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: () {
        if (onTap != null) {
          onTap!();
        }
      },
      controller: controller,
      keyboardType: keyboardType,
      autofocus: autofocus ?? false,
      onChanged: onChanged,
      readOnly: readOnly ?? false,
      validator: (val) {
        if (validator != null) {
          return validator!(val);
        }
        return null;
      },
      obscureText: obscureText ?? false,
      cursorColor: AppColors.primaryColor,
      cursorWidth: 1.w,
      enabled: enabled,
      maxLines: maxLines ?? 1,
      textAlign: TextAlign.start,
      decoration: InputDecoration(
        hintText: tr(hintText ?? ''),
        hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: AppColors.lightGrey,
          fontSize: 10.sp,
        ),
        prefixIcon: prefixIcon,
        filled: true,
        fillColor: fillColor,
        border: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(
                context.width / context.height >= 0.6 ? 5 : 10,
              ).w,
          borderSide: BorderSide(color: AppColors.darkGrey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(
                context.width / context.height >= 0.6 ? 5 : 10,
              ).w,
          borderSide: BorderSide(color: AppColors.darkGrey),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(
                context.width / context.height >= 0.6 ? 5 : 10,
              ).w,
          borderSide: BorderSide(color: Colors.red),
        ),
        errorStyle: Theme.of(
          context,
        ).textTheme.labelMedium?.copyWith(color: Colors.red, fontSize: 12.sp),
        enabledBorder: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(
                context.width / context.height >= 0.6 ? 5 : 10,
              ).w,
          borderSide: BorderSide(color: AppColors.darkGrey),
        ),
        suffixIcon: suffixIcon,
      ),
      style: Theme.of(context).textTheme.labelMedium?.copyWith(fontSize: 12.sp),
    );
  }
}
