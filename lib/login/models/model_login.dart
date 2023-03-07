// To parse this JSON data, do
//
//     final modelLogin = modelLoginFromMap(jsonString);

import 'dart:convert';

import 'package:europe_license_theory/login/models/model_user_data.dart';


ModelLogin modelLoginFromMap(String str) =>
    ModelLogin.fromMap(json.decode(str));

String modelLoginToMap(ModelLogin data) => json.encode(data.toMap());

class ModelLogin {
  ModelLogin({
    required this.status,
    required this.message,
    this.modelUserData,
    this.bearerToken,
  });

  int status;
  String message;
  ModelUserData? modelUserData;
  String? bearerToken;

  factory ModelLogin.fromMap(Map<String, dynamic> json) => ModelLogin(
        status: json["status"] == null ? 200 : json["status"],
        message: json["message"] == null ? null : json["message"],
        modelUserData:
            json["data"] == null ? null : ModelUserData.fromMap(json["data"]),
        bearerToken: json["bearer_token"] == null ? null : json["bearer_token"],
      );

  Map<String, dynamic> toMap() => {
        "status": status == null ? 200 : status,
        "message": message == null ? null : message,
        "data": modelUserData == null ? null : modelUserData!.toMap(),
        "bearer_token": bearerToken == null ? null : bearerToken,
      };
}
