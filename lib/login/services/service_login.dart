import 'dart:async';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:europe_license_theory/login/models/model_login.dart';
import 'package:europe_license_theory/login/models/model_signup.dart';
import 'package:europe_license_theory/login/services/SharedPrefrenceUser.dart';
import 'package:europe_license_theory/utilities/rest_api_utils.dart';
import 'package:http/http.dart' as http;

class ServiceLogin {
  static var time_out = const Duration(seconds: 10);
  static var client = http.Client();

  static Future<ModelSignup> SignUpFunction(String phone_number, String fcm,
      String auth_token_id, String name, File? image_file) async {
    try {
      String country = await SharedPrefrenceUser.getValueModeString("name");

      Map<String, String> _body = {
        'phone_no': phone_number,
        'fcm': fcm,
        'name': name,
        'country': country,
        // 'auth_token_id': auth_token_id,
      };

      print("_body_body ${_body.toString()}");
      print("_body_body ${RestApiUtils.signup}");

      var request =
      http.MultipartRequest("POST", Uri.parse(RestApiUtils.signup))
        ..fields.addAll(_body);
      // ..headers.addAll(_header);

      if (image_file != null) {
        var pic = await http.MultipartFile.fromPath("file", image_file.path);
        //add multipart to request
        request.files.add(pic);
      }
      // final modelProfile = modelSignupFromMap(responseString);

      var response = await request.send();
      // print("_body_body response ${response}");

      //Get the response from the server
      var responseData = await response.stream.toBytes();
      print("_body_body responseData ${responseData}");
      String responseString = String.fromCharCodes(responseData);
      print("_body_body responseString ${responseString}");

      final modelProfile = modelSignupFromMap(responseString);
      print("_body_body modelProfile ${modelProfile}");

      // RestApiUtils.GetPrintHeaderBody(
      //     RestApiUtils.fileupload_profile_update, responseString, _body, null);

      if (modelProfile.status == 201) {
        return modelProfile;
      } else {
        return ModelSignup(
            status: modelProfile.status, message: modelProfile.message);
      }
    } on TimeoutException catch (_) {
      return ModelSignup(status: 408, message: RestApiUtils.GetResponse(408));
    } on SocketException {
      return ModelSignup(status: 501, message: RestApiUtils.GetResponse(501));
    } catch (ex) {
      print("BodyResponse ex : ${ex.toString()}");
      return ModelSignup(status: 400, message: RestApiUtils.GetResponse(400));
    }
  }

  static Future<ModelLogin> LoginFunction(
      String phone_number, String fcm, String auth_token_id) async {
    try {
      Map<String, String> _body = {
        'phone_no': phone_number,
        'fcm': fcm
        // 'auth_token_id': auth_token_id,
      };
      var response = await client
          .post(Uri.parse("${RestApiUtils.login}"), body: _body)
          .timeout(time_out);

      RestApiUtils.GetPrintHeaderBody(
          RestApiUtils.login, null, _body, response);

      if (response.statusCode == 200) {
        final _model = modelLoginFromMap(response.body);
        return _model;
        // if (_model.status == 200) {
        //   return _model;
        // } else if (_model.status == 401) {
        //   return ModelLogin(
        //       status: 401, message: RestApiUtils.GetResponse(401));
        // } else {
        //   return ModelLogin(status: _model.status, message: _model.message);
        // }
      } else if (response.statusCode == 401) {
        return ModelLogin(status: 401, message: RestApiUtils.GetResponse(401));
      } else if (response.statusCode == 404) {
        return ModelLogin(
            status: 404, message: "service_response.complete_profile".tr());
      } else {
        return ModelLogin(
          status: response.statusCode,
          message: RestApiUtils.GetResponse(response.statusCode),
        );
      }
    } on TimeoutException catch (_) {
      return ModelLogin(
        status: 408,
        message: RestApiUtils.GetResponse(408),
      );
    } on SocketException {
      return ModelLogin(
        status: 501,
        message: RestApiUtils.GetResponse(501),
      );
    } catch (ex) {
      print("BodyResponse ex : ${ex.toString()}");
      return ModelLogin(status: 400, message: RestApiUtils.GetResponse(400));
    }
  }
}
