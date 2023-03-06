import 'dart:async';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:invoice/feedback/models/model_get_feedback.dart';
import 'package:invoice/services/models/model_message.dart';
import 'package:invoice/utilities/rest_api_utils.dart';

class ServiceFeedback {
  static var time_out = const Duration(seconds: 20);
  static var client = http.Client();

  static Future<ModelMessage> SendFeedback(BuildContext context, String uuid,
      String title, String email, String feedback) async {
    try {
      String XElocalization = context.locale.toLanguageTag();
      if (context.locale.languageCode == "ar" ||
          context.locale.languageCode == "en") {
        XElocalization = context.locale.languageCode;
      }

      Map<String, String> _header = {
        'Content-Type': "application/x-www-form-urlencoded",
        'Accept': 'application/json',
        'P-dir': context.locale.languageCode == "ar" ? "rtl" : 'ltr',
        'X-localization': '${XElocalization}',
        'app-name': Platform.isAndroid ? 'android' : "IOS",
      };

      final deviceInfoPlugin = DeviceInfoPlugin();
      final deviceInfo = await deviceInfoPlugin.deviceInfo;

      Map<String, dynamic> app_info = deviceInfo.toMap();

      String name = app_info["name"];
      String model = app_info["model"];
      String systemVersion = app_info["systemVersion"];

      Map<String, String> _bbody = {
        "app_info":
            "device: ${name} - model: ${model} - Version: ${systemVersion} - Local ${context.locale.languageCode}",
        "uuid": uuid,
        "feedback": feedback,
        "title": title,
        "email": email,
        "app": Platform.isAndroid
            ? 'Invoice Maker | Android'
            : "Invoice Maker | IOS",
      };

      var response = await client
          .post(Uri.parse(RestApiUtils.feedback),
              headers: _header, body: _bbody)
          .timeout(time_out);

      RestApiUtils.GetPrintHeaderBody(
          RestApiUtils.feedback, _header, _bbody, response);

      if (response.statusCode == 200) {
        return ModelMessage(response.statusCode, response.body);
      } else {
        return ModelMessage(
            response.statusCode, RestApiUtils.GetResponse(response.statusCode));
      }
    } on TimeoutException catch (_) {
      return ModelMessage(408, RestApiUtils.GetResponse(408));
    } on SocketException {
      return ModelMessage(501, RestApiUtils.GetResponse(501));
    } catch (ex) {
      print("modelClass error : ${ex.toString()}");

      return ModelMessage(510, ex.toString());
    }
  }

  static Future<ModelGetFeedback> GetFeedback(
      BuildContext context, String uuid) async {
    try {
      Map<String, String> _header = {
        'Content-Type': "application/x-www-form-urlencoded",
        'Accept': 'application/json',
        'app-name': Platform.isAndroid ? 'android' : "IOS",
      };

      var response = await client
          .get(Uri.parse("${RestApiUtils.feedback_response}/$uuid"),
              headers: _header)
          .timeout(time_out);

      RestApiUtils.GetPrintHeaderBody(
          "${RestApiUtils.feedback_response}/$uuid", _header, null, response);

      if (response.statusCode == 200) {
        final modelGetFeedback = modelGetFeedbackFromMap(response.body);

        if (modelGetFeedback.status == 200) {
          return modelGetFeedback;
        } else {
          return ModelGetFeedback(
              status: response.statusCode, message: response.body);
        }
      } else {
        return ModelGetFeedback(
            status: response.statusCode,
            message: RestApiUtils.GetResponse(response.statusCode));
      }
    } on TimeoutException catch (_) {
      return ModelGetFeedback(
          status: 408, message: RestApiUtils.GetResponse(408));
    } on SocketException {
      return ModelGetFeedback(
          status: 501, message: RestApiUtils.GetResponse(501));
    } catch (ex) {
      print("modelClass error : ${ex.toString()}");

      return ModelGetFeedback(status: 510, message: ex.toString());
    }
  }
}
