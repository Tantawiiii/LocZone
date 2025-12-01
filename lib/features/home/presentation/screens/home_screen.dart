import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loczone/core/extinsions/extinsions.dart';
import 'package:loczone/core/utils/app_assets.dart';
import 'package:loczone/core/utils/app_strings.dart';
import 'package:loczone/core/widgets/text_field_widget.dart';
import 'package:loczone/features/home/presentation/cubit/home_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [theme.primaryColor.withOpacity(0.4), Colors.white],
              begin: AlignmentDirectional.topCenter,
              end: AlignmentDirectional.bottomCenter,
              stops: [0, 0.25],
            ),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 20.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            AppStrings.appName,
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                              color: theme.primaryColor,
                            ),
                          ),
                          Image.asset(
                            AppAssets.logo,
                            fit: BoxFit.contain,
                            width: 40.w,
                            height: 40.h,
                          ),
                        ],
                      ),
                      10.0.sH,
                      TextFieldWidget(
                        hintText: AppStrings.searchSubtitle,
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.grey,
                          size: 20.h,
                        ),
                        readOnly: true,
                        fillColor: Colors.white,
                      ),
                      20.0.sH,
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
