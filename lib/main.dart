import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:loczone/app.dart';
import 'package:loczone/bloc_observer.dart';
import 'package:loczone/core/utils/app_assets.dart';
import 'package:loczone/core/utils/app_strings.dart';
import 'package:loczone/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  Bloc.observer = MyBlocObserver();
  await di.init();
  await EasyLocalization.ensureInitialized();
  final storage = FlutterSecureStorage();
  if (await storage.read(key: AppStrings.appLang) == null) {
    await storage.write(key: AppStrings.appLang, value: AppStrings.arLang);
  }
  var appLang = await storage.read(key: AppStrings.appLang);
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    EasyLocalization(
      supportedLocales: [Locale(AppStrings.enLang), Locale(AppStrings.arLang)],
      path: AppAssets.localePath,
      saveLocale: true,
      fallbackLocale: Locale(appLang ?? AppStrings.arLang),
      startLocale: Locale(appLang ?? AppStrings.arLang),
      child: MyApp(),
    ),
  );
}
