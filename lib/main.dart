import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:europe_license_theory/app_theme_work/light_theme_data.dart';
import 'package:europe_license_theory/screen_splash.dart';
import 'package:europe_license_theory/utilities/language_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();
  if (defaultTargetPlatform == Platform.isAndroid) {
    // InAppPurchase.instance.
  }

  Directory directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  // await Hive.openBox<String>(HiveUtils.database_invoice);
  // await Hive.openBox<String>(HiveUtils.database_business);
  // await Hive.openBox<String>(HiveUtils.database_customer);
  // await Hive.openBox<String>(HiveUtils.database_item);
  // await Hive.openBox<String>(HiveUtils.database_payment);
  // await Hive.openBox<String>(HiveUtils.database_setting);

  // await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.black54));

  runApp(
    EasyLocalization(
      supportedLocales: [
        Locale('ar', 'AE'),
        Locale('da', 'DA'),
        Locale('de', 'DE'),
        Locale('en', 'US'),
        Locale('es', 'ES'),
        Locale('et', 'ET'),
        Locale('fi', 'FI'),
        Locale('fil', 'FIL'),
        Locale('fr', 'FR'),
        Locale('frca', 'CA'),
        Locale('id', 'ID'),
        Locale('it', 'IT'),
        Locale('ko', 'ko'),
        Locale('ms', 'MS'),
        Locale('nl', 'NL'),
        Locale('pt', 'BR'),
        Locale('pt', 'PT'),
        Locale('ru', 'RU'),
        Locale('sv', 'SV'),
        Locale('th', 'TH'),
        Locale('tr', 'TR'),
      ],
      path: 'assets/translations',
      fallbackLocale: Locale('en', 'US'),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LanguageController()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        title: "Easy Invoice Generator",
        theme: LightThemeData.light_theme,
        themeMode: ThemeMode.light,
        home: ScreenSplash(),
        // home: DemoPage(),
      ),
    );
  }
}
