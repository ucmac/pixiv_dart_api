import 'package:json_annotation/json_annotation.dart';

import '../model/profile.dart';

part 'profile_presets_result.g.dart';

@JsonSerializable(explicitToJson: true)
class ProfilePresetsResult {
  @JsonKey(name: 'profile_presets')
  ProfilePresets profilePresets;

  ProfilePresetsResult(this.profilePresets);

  factory ProfilePresetsResult.fromJson(Map<String, dynamic> json) => _$ProfilePresetsResultFromJson(json);

  Map<String, dynamic> toJson() => _$ProfilePresetsResultToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ProfilePresets {
  List<ProfileAddress> addresses;
  List<ProfileCountry> countries;
  List<ProfileJob> jobs;
  @JsonKey(name: 'default_profile_image_urls')
  ProfileImageUrls defaultProfileImageUrls;

  ProfilePresets(this.addresses, this.countries, this.jobs, this.defaultProfileImageUrls);

  factory ProfilePresets.fromJson(Map<String, dynamic> json) => _$ProfilePresetsFromJson(json);

  Map<String, dynamic> toJson() => _$ProfilePresetsToJson(this);
}
