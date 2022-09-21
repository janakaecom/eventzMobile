import 'package:dio/dio.dart';
import 'package:eventz/configs/routes.dart';
import 'package:eventz/utils/translation/fl_translations.dart';
import 'package:eventz/view/login/login_view.dart';
import 'package:eventz/view/startup_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'configs/colors.dart';
import 'configs/fonts.dart';

void main() {
  mainDelegate();
}

void mainDelegate() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GetMaterialApp(
      home: StartupView(),
      translations: FLTranslations(),
      locale: Get.deviceLocale,
      fallbackLocale: Locale('en', 'UK'),
      theme: ThemeData(
        fontFamily: AppFonts.circularStd,
        textTheme: theme.textTheme.apply(
          fontFamily: AppFonts.circularStd,
          displayColor: AppColors.kTextDark,
        ),
        scaffoldBackgroundColor: AppColors.kBackgroundWhite,
        primarySwatch: Colors.blue,
        primaryColor: AppColors.kPrimary,
      ),
      debugShowCheckedModeBanner: false,
      getPages: Routers.route,
    );
  }
}
