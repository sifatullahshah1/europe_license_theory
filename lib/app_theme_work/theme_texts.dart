import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThemeTexts {
  ThemeTexts._();

  static String Amiri = "Amiri";
  static String Lato = "Lato";
  static String Montserrat = "Montserrat";
  static String Roboto = "Roboto";
  static String RobotoSlab = "RobotoSlab";
  static const String RobotoFlex = "RobotoFlex-Regular";
  static String LatoBold = "LatoBold";
  static String LatoLight = "LatoLight";
  static String LatoRegular = "LatoRegular";

  static const String Bold = "IBMPlexMono-Bold";
  static const String BoldItalic = "IBMPlexMono-BoldItalic";
  static const String ExtraLight = "IBMPlexMono-ExtraLight";
  static const String ExtraLightItalic = "IBMPlexMono-ExtraLightItalic";
  static const String Italic = "IBMPlexMono-Italic";
  static const String Light = "IBMPlexMono-Light";
  static const String LightItalic = "IBMPlexMono-LightItalic";
  static const String Medium = "IBMPlexMono-Medium";
  static const String MediumItalic = "IBMPlexMono-MediumItalic";
  static const String Regular = "IBMPlexMono-Regular";
  static const String SemiBold = "IBMPlexMono-SemiBold";
  static const String SemiBoldItalic = "IBMPlexMono-SemiBoldItalic";
  static const String Thin = "IBMPlexMono-Thin";
  static const String ThinItalic = "IBMPlexMono-ThinItalic";

  // static final text_title_1 = heading_06.copyWith(
  //     fontSize: 15, fontFamily: ThemeTexts.SemiBold, color: Colors.black);
  //
  // static final text_title_1 = heading_06.copyWith(
  //     fontSize: 13, fontFamily: ThemeTexts.SemiBold, color: Colors.black38);

  static const textStyleTitle = TextStyle(
      fontSize: 23,
      color: Color(0xFF222951),
      fontWeight: FontWeight.w400,
      decoration: TextDecoration.none,
      fontFamily: RobotoFlex);

  static const textStyleSubTitle = TextStyle(
      fontSize: 23,
      color: Color(0xFF222951),
      fontWeight: FontWeight.w700,
      decoration: TextDecoration.none,
      fontFamily: RobotoFlex);

  static const textStyleSubTitle2 = TextStyle(
      fontSize: 15,
      color: Color(0xFF222951),
      fontWeight: FontWeight.w400,
      decoration: TextDecoration.none,
      fontFamily: RobotoFlex );

  static const textStyleValue = const TextStyle(
      fontSize: 12,
      color: Colors.grey,
      fontWeight: FontWeight.w500,
      decoration: TextDecoration.none,
      fontFamily: ThemeTexts.SemiBold);

  static var appbar_text_style = textStyleSubTitle2.copyWith(color: Colors.black);
  static var action_text_style =
      textStyleSubTitle.copyWith(color: Colors.black);

  static var button_text_fill = textStyleSubTitle2.copyWith(color: Colors.white ,fontWeight: FontWeight.w700 );
  static var button_text_transparent = textStyleSubTitle2.copyWith(fontWeight: FontWeight.w700);
  static var snakbar_text = TextStyle(
      color: Colors.white, fontSize: 16.5, fontWeight: FontWeight.w600);

  static const textCupertinoTitleStyle = textStyleSubTitle2;

  static var floating_button_text = TextStyle(
    fontSize: 17,
    fontFamily: MediumItalic,
    color: Colors.white,
  );


  static var textormfield_lable = TextStyle(
    fontSize: 20,
    fontFamily: LatoRegular,
    fontWeight: FontWeight.w600,
  );

  static var textormfield_value = TextStyle(
    fontSize: 20,
    fontFamily: LatoRegular,
    fontWeight: FontWeight.w600,
  );

  static var textormfield_hint = TextStyle(
    fontSize: 20,
    fontFamily: LatoRegular,
    fontWeight: FontWeight.w600,
  );


  // static final textThemeLT = TextTheme(
  //   headline6: heading_06.copyWith(color: ThemeColors.headline6_color_lt),
  //   headline1: heading_01.copyWith(color: ThemeColors.headline1_color_lt),
  //   headline2: heading_02.copyWith(color: ThemeColors.headline2_color_lt),
  //   headline3: heading_03.copyWith(color: ThemeColors.headline3_color_lt),
  //   headline4: heading_04.copyWith(color: ThemeColors.headline4_color_lt),
  //   headline5: heading_05.copyWith(color: ThemeColors.headline5_color_lt),
  //   subtitle1: subtitle_01.copyWith(color: ThemeColors.subtitle1_color_lt),
  //   subtitle2: subtitle_02.copyWith(color: ThemeColors.subtitle2_color_lt),
  //   bodyText1: bodyText_01.copyWith(color: ThemeColors.bodyText1_color_lt),
  //   bodyText2: bodyText_02.copyWith(color: ThemeColors.bodyText2_color_lt),
  //   caption: caption.copyWith(color: ThemeColors.caption_color_lt),
  //   overline: overline.copyWith(color: ThemeColors.overline_color_lt),
  // );
}
