import 'package:europe_license_theory/login/models/model_country.dart';
import 'package:europe_license_theory/login/models/model_user_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefrenceUser {
  static SaveUserData(ModelUserData modalUser) {
    saveValueModeString("user_id", modalUser.id!);
    saveValueModeString("user_name", modalUser.name);
    saveValueModeString("user_phoneNo", modalUser.phoneNo);
    saveValueModeString("user_gender", modalUser.gender!);
    saveValueModeString("user_bio", modalUser.bio!);
    saveValueModeString("user_city", modalUser.city!);
    saveValueModeString("user_dob", modalUser.dob!);
    saveValueModeString("user_email", modalUser.email!);
    saveValueModeString("user_interest", modalUser.interest!);
    saveValueModeString("user_profession", modalUser.profession!);
    saveValueModeString("user_fcm", modalUser.fcm!);
    saveValueModeString("user_profile_pic", modalUser.profile_pic!);
  }

  static SaveUserCountry(ModelCountry modelCountry) {
    saveValueModeString("name", modelCountry.name);
    saveValueModeString("flag", modelCountry.flag);
    saveValueModeString("code", modelCountry.code);
    saveValueModeString("alpha2", modelCountry.alpha2);
    saveValueModeString("alpha3", modelCountry.alpha3);
    saveValueModeString("currency_code", modelCountry.currency_code);
    saveValueModeString("currency_symbol", modelCountry.currency_symbol);
    saveValueModeString("currency_name", modelCountry.currency_name);
    saveValueModeString("time_zone", modelCountry.time_zone);
    saveValueModeString("latitude", "${modelCountry.latitude}");
    saveValueModeString("longitude", "${modelCountry.longitude}");
  }

  //====================Get Values======================================================

  static Future<ModelCountry> GetUserCountry() async {
    String name = await getValueModeString("name");
    String flag = await getValueModeString("flag");
    String code = await getValueModeString("code");
    String alpha2 = await getValueModeString("alpha2");
    String alpha3 = await getValueModeString("alpha3");
    String currency_code = await getValueModeString("currency_code");
    String currency_symbol = await getValueModeString("currency_symbol");
    String currency_name = await getValueModeString("currency_name");
    String time_zone = await getValueModeString("time_zone");

    String latitude = await getValueModeString("latitude");
    String longitude = await getValueModeString("longitude");

    return ModelCountry(
      name: name,
      flag: flag,
      code: code,
      alpha2: alpha2,
      alpha3: alpha3,
      currency_code: currency_code,
      currency_symbol: currency_symbol,
      currency_name: currency_name,
      time_zone: time_zone,
      latitude: double.parse(latitude),
      longitude: double.parse(longitude),
    );
  }

  static Future<ModelUserData> GetUserData() async {
    String user_id = await getValueModeString("user_id");
    String user_name = await getValueModeString("user_name");
    String user_phoneNo = await getValueModeString("user_phoneNo");
    String user_gender = await getValueModeString("user_gender");
    String user_bio = await getValueModeString("user_bio");
    String user_city = await getValueModeString("user_city");
    String user_dob = await getValueModeString("user_dob");
    String user_email = await getValueModeString("user_email");
    String user_interest = await getValueModeString("user_interest");
    String user_profession = await getValueModeString("user_profession");
    String user_fcm = await getValueModeString("user_fcm");
    String user_profile_pic = await getValueModeString("user_profile_pic");

    return ModelUserData(
      id: user_id,
      phoneNo: user_phoneNo,
      name: user_name,
      email: user_email,
      profession: user_profession,
      city: user_city,
      dob: user_dob,
      gender: user_gender,
      interest: user_interest,
      bio: user_bio,
      fcm: user_fcm,
      profile_pic: user_profile_pic,
    );
  }

  ///=================================================

  static Future<String> getValueModeString(String _key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String return_key = (prefs.getString(_key) ?? "");
    print("isDarkMode return_key $return_key");
    return return_key;
  }

  //========== Save Values =======================================

  static void saveValueModeString(String _key, String _value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, _value);
    print("isDarkMode isDarkModeOn $_value");
  }
}
