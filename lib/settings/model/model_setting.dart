
import 'package:europe_license_theory/login/models/model_country.dart';

class ModelSetting {
  String due_term;
  String number_formate_index;
  String number_formate_char;
  String date_formate;
  String uuid;
  ModelCountry modelCountry;

  ModelSetting({
    required this.due_term,
    required this.number_formate_index,
    required this.number_formate_char,
    required this.date_formate,
    required this.modelCountry,
    required this.uuid,
  });

  factory ModelSetting.fromJson(Map<String, dynamic> json) => ModelSetting(
        due_term: json["due_term"],
        number_formate_index: json["number_formate_index"],
        number_formate_char: json["number_formate_char"],
        date_formate: json["date_formate"],
        uuid: json["uuid"],
        modelCountry: ModelCountry.fromJson(json["modelCountry"]),
      );

  Map<String, dynamic> toJson() => {
        "due_term": due_term,
        "number_formate_index": number_formate_index,
        "number_formate_char": number_formate_char,
        "date_formate": date_formate,
        "uuid": uuid,
        "modelCountry": modelCountry.toJson(),
      };
}
