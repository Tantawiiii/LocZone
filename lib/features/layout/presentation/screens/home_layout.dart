import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loczone/features/layout/presentation/cubit/layout_cubit.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<LayoutCubit>(context);
    return BlocBuilder<LayoutCubit, LayoutState>(
      builder: (context, state) {
        return Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottomNavIndex(index);
            },
            items:
                cubit.bottomNavItems.map((item) {
                  return BottomNavigationBarItem(
                    icon: Icon(item.keys.first),
                    label: item.values.first.tr(),
                  );
                }).toList(),
          ),
          body: cubit.screens[cubit.currentIndex],
        );
      },
    );
  }
}
