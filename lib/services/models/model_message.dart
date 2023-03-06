// To parse this JSON data, do
//
//     final modelMessage = modelMessageFromJson(jsonString);

import 'dart:convert';

ModelMessage modelMessageFromJson(String str) =>
    ModelMessage.fromJson(json.decode(str));

String modelMessageToJson(ModelMessage data) => json.encode(data.toJson());

class ModelMessage {
  ModelMessage(this.status, this.message);

  int status;
  String message;

  factory ModelMessage.fromJson(Map<String, dynamic> json) => ModelMessage(
        json["status"],
        json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
