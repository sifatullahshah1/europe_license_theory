import 'package:easy_localization/easy_localization.dart';
import 'package:europe_license_theory/app_theme_work/theme_texts.dart';
import 'package:europe_license_theory/app_theme_work/widgets_reusing.dart';
import 'package:europe_license_theory/utilities/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
// import 'package:flutter_svg/flutter_svg.dart'
import 'package:lottie/lottie.dart';

class RestApiUtils {
  RestApiUtils._();

  // APIs Production Links
  // static String ip_config = "https://cv.codematics.co/api/";

  // APIs development Links
  static String ip_config = "http://cv.sidrafoundation.pk/api/";


  static final String ImageUrl = "https://cv.codematics.co/storage/invoice_template_image/";

  static final String signup = ip_config + "signup";
  static final String login = ip_config + "login";



  //==================================================================

  static final String feedback = ip_config + "feedback";
  static final String feedback_response = ip_config + "feedback-response";

  //Response Status and Message
  static String error_400 = "Error occurred";
  static String error_401 = "Unauthorized";
  static String error_402 = "Provide all values";
  static String error_404 = "Not found exception";
  static String error_405 = "Method not allowed";
  static String error_408 = "Time out error, Please try again";
  static String error_500 = "Internal server error";
  static String error_501 = "You are not connected to internet";
  static String error_default = "Unknown server error occurred";

  static String GetResponse(int status) {
    switch (status) {
      case 400:
        print("HelloGetResponse  error_400 ${error_400}");
        return error_400;
      case 401:
        print("HelloGetResponse  error_401 ${error_401}");
        return error_401;
      case 402:
        print("HelloGetResponse  error_402 ${error_402}");
        return error_402;
      case 404:
        print("HelloGetResponse  error_400 ${error_404}");
        return error_404;
      case 405:
        print("HelloGetResponse  error_405 ${error_405}");
        return error_405;
      case 408:
        print("HelloGetResponse  error_408 ${error_408}");
        return error_408;
      case 500:
        print("HelloGetResponse  error_500 ${error_500}");
        return error_500;
      case 501:
        print("HelloGetResponse  error_501 ${error_501}");
        return error_501;
      default:
        print("HelloGetResponse  error_default ${error_default}");
        return error_default;
    }
  }

  static void GetPrintHeaderBody(url, header, body, response) {
    print("BodyResponse  url ${url}");
    print("BodyResponse  header ${header}");
    print("BodyResponse  body ${body}");
    if (response != null) {
      print("BodyResponse  response ${response.statusCode} : ${response.body}");
    }
  }

  static ShowLoadingView(BuildContext context, {isBackgroundWhite = true}) {
    return Center(
      child: Container(
        width: 145,
        height: 145,
        decoration: BoxDecoration(
          color: isBackgroundWhite ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Load a Lottie file from your assets
            Container(
              width: 80,
              height: 80,
              child: Lottie.asset(AppAssets.loading_view, width: 120),
            ),
            SizedBox(height: 18),
            Text(
              "loading_data".tr(),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.subtitle2,
            )
          ],
        ),
      ),
    );
  }

  static ShowLoadingDialog(BuildContext context, {barrier_dismissible = true}) {
    showDialog(
      context: context,
      barrierDismissible: barrier_dismissible,
      builder: (context) => Center(
        child: ShowLoadingView(context),
      ),
    );
  }

  static Widget ShowErrorWithReloadView(context, String message, String path,
      {GestureTapCallback? onPresseddd, bool isImageSVG = false}) {
    return ListView(
      children: [
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 40),
          child: Column(
            children: [
              isImageSVG
                  ? SvgPicture.asset(
                      path,
                      width: 130,
                      height: 130,
                    )
                  : Container(
                      width: 180,
                      height: 180,
                      child: Lottie.asset(path),
                    ),
              SizedBox(height: 25),
              Text(
                "$message",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 19,
                    color: Colors.black87),
              ),
              SizedBox(height: 25),
              onPresseddd != null
                  ? WidgetsReusing.GetTextButton(context, "reload".tr(),
                      onPresseddd, EdgeInsets.symmetric(horizontal: 20))
                  : SizedBox()
            ],
          ),
        ),
      ],
    );
  }


}
