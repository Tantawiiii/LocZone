import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension Sizer on BuildContext {
  double get height => MediaQuery.of(this).size.height;

  double get width => MediaQuery.of(this).size.width;
}

extension EmailValidation on String {
  bool isValidEmail() {
    final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@(gmail\.com|yahoo\.com|hotmail\.com|outlook\.com)$',
    );
    return emailRegex.hasMatch(this);
  }
}

extension Spacer on double {
  SizedBox get sH => SizedBox(height: this.h);

  SizedBox get sW => SizedBox(width: this.w);
}
