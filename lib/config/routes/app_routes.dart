import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loczone/features/categories/presentation/cubit/categories_cubit.dart';
import 'package:loczone/features/categories/presentation/screens/category_screen.dart';
import 'package:loczone/features/home/presentation/cubit/home_cubit.dart';
import 'package:loczone/features/home/presentation/screens/home_screen.dart';
import 'package:loczone/features/layout/presentation/cubit/layout_cubit.dart';
import 'package:loczone/features/layout/presentation/screens/home_layout.dart';
import 'package:loczone/features/splash/presentation/cubit/splash_cubit.dart';
import 'package:loczone/features/splash/presentation/screens/splash_screen.dart';
import 'package:loczone/injection_container.dart' as di;

class Routes {
  static const String splash = '/splash';
  static const String layout = '/layout';
  static const String home = '/home';
  static const String category = '/category';
}

class AppRoutes {
  static final AppRoutes instance = AppRoutes();

  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) => di.sl<SplashCubit>(),
                child: const SplashScreen(),
              ),
        );
      case Routes.layout:
        return MaterialPageRoute(
          builder:
              (_) => MultiBlocProvider(
                providers: [
                  BlocProvider<LayoutCubit>(
                    create: (context) => di.sl<LayoutCubit>(),
                  ),
                  BlocProvider<HomeCubit>(
                    create: (context) => di.sl<HomeCubit>(),
                  ),
                ],
                child: const HomeLayout(),
              ),
        );
      case Routes.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

        case Routes.category:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
            create: (context) => di.sl<CategoriesCubit>(),
            child: const CategoriesScreen(),
          ),
        );
      default:
        return null;
    }
  }
}
