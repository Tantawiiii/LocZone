import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:loczone/core/utils/app_strings.dart';
import 'package:loczone/features/home/presentation/screens/home_screen.dart';

import '../../../categories/presentation/screens/category_screen.dart';
part 'layout_state.dart';

class LayoutCubit extends Cubit<LayoutState> {
  LayoutCubit() : super(LayoutInitial());

  List<Map<IconData, String>> bottomNavItems = [
    {Icons.favorite: AppStrings.wishlist},
    {Icons.grid_view_outlined: AppStrings.categories},
    {Icons.home: AppStrings.home},
    {Icons.shopping_cart: AppStrings.myCart},
    {Icons.person: AppStrings.account},
  ];
  int currentIndex = 2;
  List<Widget> screens = [Container(), CategoriesScreen(), HomeScreen(), Container(), Container()];

  void changeBottomNavIndex(int index) {
    currentIndex = index;
    emit(ChangeIndexState());
  }
}
