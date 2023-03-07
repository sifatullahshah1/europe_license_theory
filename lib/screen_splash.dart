import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:europe_license_theory/app_theme_work/theme_texts.dart';
import 'package:europe_license_theory/login/screens/screen_language_selection.dart';
import 'package:europe_license_theory/login/screens/screen_verify_number.dart';
import 'package:europe_license_theory/screen_dashboard.dart';
import 'package:europe_license_theory/utilities/app_assets.dart';
import 'package:europe_license_theory/utilities/constant_functions.dart';
import 'package:europe_license_theory/utilities/language_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ScreenSplash extends StatefulWidget {
  @override
  _ScreenSplashState createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  // late AppLifecycleReactor _appLifecycleReactor;

  @override
  void initState() {
    // AppOpenAdManager appOpenAdManager = AppOpenAdManager()..loadAppOpenAd();
    // _appLifecycleReactor =
    //     AppLifecycleReactor(appOpenAdManager: appOpenAdManager);

    var dt = DateTime.now();
    print(dt.weekday);

    Timer(const Duration(seconds: 3), callback);

    super.initState();
  }

  void callback() {
    ConstantFunctions.getSharePrefModebool("is_show_board")
        .then((is_show_board) {
      if (is_show_board) {
        // ConstantFunctions.OpenNewScreenClean(
        //     context, ScreenLanguageSelection(is_from_splash: true));
        ConstantFunctions.OpenNewScreenClean(context, ScreenVerifyNumber());
      } else {
        ConstantFunctions.OpenNewScreenClean(context, ScreenVerifyNumber());
        // ConstantFunctions.OpenNewScreenClean(context, ScreenDummyImage());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    context.watch<LanguageController>();
    // print('Hello Language ${context.locale.languageCode}');
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Load a Lottie file from your assets
            // Container(
            //   width: 200,
            //   height: 200,
            //   // child: Lottie.asset(AppAssets.invoice_lottie, width: 120),
            //   child: Image.asset(AppAssets.app_icon, width: 120),
            // ),
            SizedBox(height: 25),

            Text(
              "Europe License Theory",
              style: TextStyle(
                  fontSize: 17,
                  color: Colors.black,
                  fontFamily: ThemeTexts.BoldItalic),
            )
          ],
        ),
      ),
    );
  }
}
