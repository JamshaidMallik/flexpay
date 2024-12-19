import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flexpay/firebase_options.dart';
import 'package:flexpay/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sizer/sizer.dart';

import 'constant/constant.dart';
import 'dependency_injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  DependencyInjection.init();
  await Firebase.initializeApp(
    options: Platform.isAndroid ? DefaultFirebaseOptions.android : DefaultFirebaseOptions.ios,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
        builder: (context, orientation, screenType) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          defaultTransition: Transition.fadeIn,
          transitionDuration: const Duration(milliseconds: 700),
          title: 'FlexPay',
          theme: ThemeData(
              colorScheme: ColorScheme(
                primary: primaryColor,
                primaryContainer: primaryColor.withOpacity(0.8),
                secondary: greyColor,
                secondaryContainer: greyColor.withOpacity(0.8),
                surface: whiteColor,
                error: Colors.red,
                onPrimary: Colors.white,
                onSecondary: Colors.white,
                onSurface: Colors.black,
                onError: Colors.white,
                brightness: Brightness.dark,
              ),
              expansionTileTheme: const ExpansionTileThemeData(
                iconColor: Colors.white,
              ),
              appBarTheme: AppBarTheme(
                  elevation: 0.0,
                  backgroundColor: Colors.white,
                  scrolledUnderElevation: 0.0,
                  centerTitle: true,
                  titleTextStyle: blackFontStyle(fontSize: kAppBarFontSize, fontWeight: FontWeight.w700)),
              scaffoldBackgroundColor: appBgColor,
              useMaterial3: true,
            ),
          getPages: AppRoutes.routes,
          initialRoute: AppRoutes.splash,
        );
      }
    );
  }
}

