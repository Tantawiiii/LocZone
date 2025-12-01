import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:loczone/core/network/network_checker.dart';
import 'package:loczone/features/categories/presentation/cubit/categories_cubit.dart';
import 'package:loczone/features/home/presentation/cubit/home_cubit.dart';
import 'package:loczone/features/layout/presentation/cubit/layout_cubit.dart';
import 'package:loczone/features/splash/presentation/cubit/splash_cubit.dart';
import 'package:loczone/features/products/presentation/cubit/products_cubit.dart';

var sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory<LayoutCubit>(() => LayoutCubit());
  sl.registerFactory<SplashCubit>(() => SplashCubit());
  sl.registerFactory<HomeCubit>(() => HomeCubit());
  sl.registerFactory<CategoriesCubit>(() => CategoriesCubit());
  sl.registerFactory<ProductsCubit>(() => ProductsCubit());
  sl.registerLazySingleton<LogInterceptor>(
    () => LogInterceptor(
      request: true,
      requestHeader: true,
      responseHeader: true,
      responseBody: true,
      requestBody: true,
      error: true,
    ),
  );
  sl.registerLazySingleton<NetworkChecker>(
    () => NetworkCheckerImpl(connectivityResult: sl()),
  );
  final List<ConnectivityResult> connectivityResult =
      await (Connectivity().checkConnectivity());
  sl.registerLazySingleton<List<ConnectivityResult>>(() => connectivityResult);
  sl.registerLazySingleton<Dio>(() => Dio());
  var storage = FlutterSecureStorage();
  sl.registerLazySingleton<FlutterSecureStorage>(() => storage);
}
