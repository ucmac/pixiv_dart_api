import 'package:json_annotation/json_annotation.dart';

part 'profile_image_urls.g.dart';

@JsonSerializable(explicitToJson: true)
class ProfileImageUrls {
  String medium;

  ProfileImageUrls(this.medium);

  factory ProfileImageUrls.fromJson(Map<String, dynamic> json) => _$ProfileImageUrlsFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileImageUrlsToJson(this);
}
