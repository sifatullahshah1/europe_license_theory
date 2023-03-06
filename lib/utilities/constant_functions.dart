import 'package:easy_localization/easy_localization.dart';
import 'package:europe_license_theory/app_theme_work/widgets_reusing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class ConstantFunctions {
  ConstantFunctions._();

  static final now = DateTime.now();
  static final formattedDatefinal = DateFormat('dd-MM-yyyy');
  static final calendar_formate_now2 = DateFormat('EEE, dd-MM-yyyy');

  static const double padding = 20;
  static const double avatarRadius = 45;

  static const constant_margin = EdgeInsets.symmetric(vertical: 7);
  static const constant_padding =
      EdgeInsets.symmetric(horizontal: 15, vertical: 15);

  static const constant_decoration = BoxDecoration(
      color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(1)));

  static Future<String> GetXElocalization(BuildContext context) async {
    String XElocalization = context.locale.languageCode; // single
    try {
      if (context.locale.languageCode == "fr" ||
          context.locale.languageCode == "pt" ||
          context.locale.languageCode == "pt" ||
          context.locale.languageCode == "zh") {
        XElocalization = context.locale.toLanguageTag();
      }
      return XElocalization;
    } catch (e) {
      return XElocalization;
    }
  }

  static Future<bool> getSharePrefModebool(String _key) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool return_key = (prefs.getBool(_key) ?? false);
      // print("isDarkMode isDarkModeOn $return_key");
      return return_key;
    } catch (e) {
      return false;
    }
  }

  static Future<String> getSharePrefModeString(String _key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String return_key = (prefs.getString(_key) ?? "");

    return return_key;
  }

  static Future<int> getSharePrefModeInt(String _key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int return_key = (prefs.getInt(_key) ?? 1);
    return return_key;
  }

  static void saveSharePrefModebool(String _key, bool _value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_key, _value);

  }

  static void saveSharePrefModeString(String _key, String _value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, _value);

  }

  static void saveSharePrefModeInt(String _key, int _value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_key, _value);

  }

  static String NumberFormate(String number, int index, String char) {
    //split string
    var arr = number.split('.');
    String first = arr[0];
    String second = "00";
    if (arr.length > 1) second = arr[1];

    String priceInText = "";
    int counter = 0;
    for (int i = (first.length - 1); i >= 0; i--) {
      counter++;
      String str = first[i];
      if ((counter % index) != 0 && i != 0) {
        priceInText = "$str$priceInText";
      } else if (i == 0) {
        priceInText = "$str$priceInText";
      } else {
        priceInText = "$char$str$priceInText";
      }
    }
    return "${priceInText.trim()}.${second}";
  }

  //========= URL Launch ============================================

  static Future MakeEmail(context,
      {required String toEmail,
      required String subject,
      required String body}) async {
    try {
      final launchUri =
          'mailto:$toEmail?subject=${Uri.encodeFull(subject)}&body=${Uri.encodeFull(body)}';
      canLaunchUrl(Uri.parse(launchUri)).then((value) async {
        if (value) {
          await launchUrl(Uri.parse(launchUri));
        } else {
          WidgetsReusing.getSnakeBar(context, "Not supported email");
        }
      });
    } catch (e) {
      WidgetsReusing.getSnakeBar(context, "${e.toString()}");
    }
  }

  static Future MakePhoneCall(context, {required String phone_number}) async {
    try {
      final Uri launchUri = Uri(
        scheme: 'tel',
        path: phone_number,
      );
      canLaunchUrl(launchUri).then((value) async {
        if (value) {
          await launchUrl(launchUri);
        } else {
          WidgetsReusing.getSnakeBar(context, "Not supported call");
        }
      });
    } catch (e) {
      WidgetsReusing.getSnakeBar(context, "${e.toString()}");
    }
  }

  static Future<void> MakePhoneSms(context,
      {required String phone_number, required String message}) async {
    try {
      final Uri launchUri =
          Uri(scheme: 'sms', path: phone_number, queryParameters: {
        "": "",
        "body": "$message",
      });
      await launchUrl(launchUri);
    } catch (e) {
      WidgetsReusing.getSnakeBar(context, "${e.toString()}");
    }
  }

  static Future OpenUrlSite(context, String launchUri) async {
    try {
      canLaunchUrl(Uri.parse(launchUri)).then((value) async {
        if (value) {
          await launchUrl(Uri.parse(launchUri));
        } else {
          WidgetsReusing.getSnakeBar(context, "Not supported site");
        }
      });
    } catch (e) {
      WidgetsReusing.getSnakeBar(context, "${e.toString()}");
    }
  }

  //========= URL Launch ============================================
  static PageRouteBuilder OpenNewActivity(screen) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (context, animation, _) {
        return FadeTransition(opacity: animation, child: screen);
      },
    );
  }

  static PageRouteBuilder? OpenNewScreenClean(context, material_route_page) {
    Navigator.of(context).pushAndRemoveUntil(
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 200),
          pageBuilder: (context, animation, _) {
            return FadeTransition(
                opacity: animation, child: material_route_page);
          },
        ),
        (Route<dynamic> route) => false);
  }
}
