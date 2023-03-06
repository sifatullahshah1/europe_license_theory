class ModelRewardAdsIdStorage {
  String template_id;

  ModelRewardAdsIdStorage({
    required this.template_id,
  });

  factory ModelRewardAdsIdStorage.fromJson(Map<String, dynamic> json) =>
      ModelRewardAdsIdStorage(
        template_id: json["template_id"],
      );

  Map<String, dynamic> toJson() => {
        "template_id": template_id,
      };
}
