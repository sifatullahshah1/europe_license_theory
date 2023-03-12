import 'package:europe_license_theory/app_theme_work/theme_texts.dart';
import 'package:europe_license_theory/utilities/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WidgetsSpecific {
  static const box_decoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.all(
      Radius.circular(0),
    ),
  );

  //============== Checkbox View ===============================================

  static Widget GetCheckBoxField(String title, bool isValue) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        children: [
          Container(
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Colors.white),
            child: isValue ? checkbox_checked : checkbox_unchecked,
          ),
          SizedBox(width: 5),
          Text("$title", style: ThemeTexts.textStyleSubTitle2)
        ],
      ),
    );
  }

  // static Widget GetProfileImage(
  //     _isError, modalUserfinal, double radius, onBackgroundImageErro) {
  //   return !_isError && modalUserfinal != null
  //       ? CircleAvatar(
  //           radius: radius,
  //           backgroundColor: Colors.white,
  //           backgroundImage: NetworkImage(
  //               "${RestApiUtils.ImageUrl_assets}${modalUserfinal!.id}/${modalUserfinal!.profile_pic}"),
  //           onBackgroundImageError: onBackgroundImageErro,
  //           child: _isError
  //               ? CircleAvatar(
  //                   radius: radius,
  //                   backgroundImage: AssetImage(AppAssets.logo_placeholder))
  //               : SizedBox())
  //       : CircleAvatar(
  //           radius: radius,
  //           backgroundImage: AssetImage(AppAssets.logo_placeholder));
  // }

  static Widget checkbox_unchecked = SvgPicture.asset(
    AppAssets.checkbox_unchecked,
    width: 25,
    height: 25,
  );

  static Widget check_circle = SvgPicture.asset(
    AppAssets.check_circle,
    width: 25,
    height: 25,
  );

  static Widget subscription_banner = SvgPicture.asset(
    AppAssets.subscription_banner,
  );

  static Widget checkbox_checked =
      SvgPicture.asset(AppAssets.checkbox_checked, width: 25, height: 25);

  static Widget subscription_close =
      SvgPicture.asset(AppAssets.subscription_close, width: 25, height: 25);

  static Widget subscription_star = SvgPicture.asset(
    AppAssets.subscription_star,
    width: 40,
    height: 40,
  );

//============== Checkbox View ===============================================

}
