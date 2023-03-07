// To parse this JSON data, do
//
//     final modelSignup = modelSignupFromMap(jsonString);

import 'dart:convert';

import 'package:europe_license_theory/login/models/model_user_data.dart';


ModelSignup modelSignupFromMap(String str) =>
    ModelSignup.fromMap(json.decode(str));

String modelSignupToMap(ModelSignup data) => json.encode(data.toMap());

class ModelSignup {
  ModelSignup({
    required this.status,
    required this.message,
    this.modelUserData,
    this.bearerToken,
  });

  int status;
  String message;
  ModelUserData? modelUserData;
  String? bearerToken;

  factory ModelSignup.fromMap(Map<String, dynamic> json) => ModelSignup(
        status: json["status"] == null ? 201 : json["status"],
        message: json["message"] == null ? null : json["message"],
        modelUserData:
            json["data"] == null ? null : ModelUserData.fromMap(json["data"]),
        bearerToken: json["bearer_token"] == null ? null : json["bearer_token"],
      );

  Map<String, dynamic> toMap() => {
        "status": status == null ? 201 : status,
        "message": message == null ? null : message,
        "data": modelUserData == null ? null : modelUserData!.toMap(),
        "bearer_token": bearerToken == null ? null : bearerToken,
      };
}
