class ModelUserData {
  ModelUserData({
    this.id,
    required this.phoneNo,
    required this.name,
    this.email,
    this.profession,
    this.city,
    this.dob,
    this.gender,
    this.interest,
    this.bio,
    this.fcm,
    this.isBan,
    this.profile_pic,
  });

  String? id;
  String phoneNo;
  String name;
  String? email;
  String? profession;
  String? city;
  String? dob;
  String? gender;
  String? interest;
  String? bio;
  String? fcm;
  bool? isBan;
  String? profile_pic;

  factory ModelUserData.fromMap(Map<String, dynamic> json) => ModelUserData(
        id: json["_id"] == null ? "" : json["_id"],
        phoneNo: json["phone_no"] == null ? "" : json["phone_no"],
        name: json["name"] == null ? "" : json["name"],
        email: json["email"] == null ? "" : json["email"],
        profession: json["profession"] == null ? "" : json["profession"],
        city: json["city"] == null ? "" : json["city"],
        dob: json["dob"] == null ? "" : json["dob"],
        gender: json["gender"] == null ? "" : json["gender"],
        interest: json["interest"] == null ? "" : json["interest"],
        bio: json["bio"] == null ? "" : json["bio"],
        fcm: json["fcm"] == null ? "" : json["fcm"],
        isBan: json["is_ban"] == null ? false : json["is_ban"],
        profile_pic: json["profile_pic"] == null ? "" : json["profile_pic"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id == null ? "" : id,
        "phone_no": phoneNo,
        "name": name,
        "email": email == null ? "" : email,
        "profession": profession == null ? "" : profession,
        "city": city == null ? "" : city,
        "dob": dob == null ? "" : dob,
        "gender": gender == null ? "" : gender,
        "interest": interest == null ? "" : interest,
        "bio": bio == null ? "" : bio,
        "fcm": fcm == null ? "" : fcm,
        "is_ban": isBan == null ? false : isBan,
        "profile_pic": profile_pic == null ? "" : profile_pic,
      };
}
