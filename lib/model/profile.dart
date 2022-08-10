import 'package:json_annotation/json_annotation.dart';

part 'profile.g.dart';

@JsonSerializable(explicitToJson: true)
class ProfileAddress {
  int id;
  String name;
  @JsonKey(name: 'is_global')
  bool isGlobal;

  ProfileAddress(this.id, this.name, this.isGlobal);

  factory ProfileAddress.fromJson(Map<String, dynamic> json) => _$ProfileAddressFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileAddressToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ProfileCountry {
  String code;
  String name;

  ProfileCountry(this.code, this.name);

  factory ProfileCountry.fromJson(Map<String, dynamic> json) => _$ProfileCountryFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileCountryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ProfileJob {
  int id;
  String name;

  ProfileJob(this.id, this.name);

  factory ProfileJob.fromJson(Map<String, dynamic> json) => _$ProfileJobFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileJobToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ProfileImageUrls {
  String medium;

  ProfileImageUrls(this.medium);

  factory ProfileImageUrls.fromJson(Map<String, dynamic> json) => _$ProfileImageUrlsFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileImageUrlsToJson(this);
}
