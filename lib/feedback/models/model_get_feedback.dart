// To parse this JSON data, do
//
//     final modelGetFeedback = modelGetFeedbackFromMap(jsonString);

import 'dart:convert';

ModelGetFeedback modelGetFeedbackFromMap(String str) =>
    ModelGetFeedback.fromMap(json.decode(str));

String modelGetFeedbackToMap(ModelGetFeedback data) =>
    json.encode(data.toMap());

class ModelGetFeedback {
  ModelGetFeedback({
    required this.status,
    required this.message,
    this.feedbackResponse,
  });

  int status;
  String message;
  List<FeedbackResponse>? feedbackResponse;

  factory ModelGetFeedback.fromMap(Map<String, dynamic> json) =>
      ModelGetFeedback(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        feedbackResponse: json["feedback_responses"] == null
            ? null
            : List<FeedbackResponse>.from(json["feedback_responses"]
                .map((x) => FeedbackResponse.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "feedback_responses": feedbackResponse == null
            ? null
            : List<dynamic>.from(feedbackResponse!.map((x) => x.toMap())),
      };
}

class FeedbackResponse {
  FeedbackResponse({
    this.id,
    this.uuid,
    this.ticket,
    this.email,
    this.title,
    this.feedback,
    this.app,
    this.appInfo,
    this.isResponded,
    this.response,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? uuid;
  String? ticket;
  String? email;
  String? title;
  String? feedback;
  String? app;
  String? appInfo;
  bool? isResponded;
  String? response;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory FeedbackResponse.fromMap(Map<String, dynamic> json) =>
      FeedbackResponse(
        id: json["id"] == null ? null : json["id"],
        uuid: json["uuid"] == null ? null : json["uuid"],
        ticket: json["ticket"] == null ? null : json["ticket"],
        email: json["email"] == null ? null : json["email"],
        title: json["title"] == null ? null : json["title"],
        feedback: json["feedback"] == null ? null : json["feedback"],
        app: json["app"] == null ? null : json["app"],
        appInfo: json["app_info"] == null ? null : json["app_info"],
        isResponded: json["is_responded"] == null ? null : json["is_responded"],
        response: json["response"] == null ? null : json["response"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "uuid": uuid == null ? null : uuid,
        "ticket": ticket == null ? null : ticket,
        "email": email == null ? null : email,
        "title": title == null ? null : title,
        "feedback": feedback == null ? null : feedback,
        "app": app == null ? null : app,
        "app_info": appInfo == null ? null : appInfo,
        "is_responded": isResponded == null ? null : isResponded,
        "response": response == null ? null : response,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
      };
}
