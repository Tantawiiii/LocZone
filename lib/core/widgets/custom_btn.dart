import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loczone/core/extinsions/extinsions.dart';
import 'package:loczone/core/utils/app_colors.dart';


class CustomBtn extends StatelessWidget {
  final String title;
  final Function onPressed;
  final double width;
  final double height;
  final bool isLoading;
  final double? fontSize;
  final Color? color;
  const CustomBtn({
    super.key,
    required this.title,
    required this.onPressed,
    required this.width,
    required this.height,
    this.isLoading = false,
    this.fontSize,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressed(),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: height,
        alignment: Alignment.center,
        width: width,
        decoration: BoxDecoration(
          color: color ?? AppColors.primaryColor,
          borderRadius:
              BorderRadius.circular(
                context.width / context.height >= 0.6 ? 5 : 10,
              ).w,
        ),
        child:
            isLoading
                ? Center(
                  child: CupertinoActivityIndicator(
                    color: Colors.white,
                    radius: 12.r,
                  ),
                )
                : Text(
                  title,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize:
                        fontSize ??
                        (context.width / context.height >= 0.6 ? 15.sp : 18.sp),
                  ),
                ).tr(),
      ),
    );
  }
}
