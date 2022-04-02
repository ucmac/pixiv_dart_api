import 'package:json_annotation/json_annotation.dart';

part 'image_urls.g.dart';

@JsonSerializable(explicitToJson: true)
class ImageUrls {
  @JsonKey(name: 'square_medium')
  String squareMedium;
  String medium;
  String large;
  String? original;

  ImageUrls(this.squareMedium, this.medium, this.large, this.original);

  factory ImageUrls.fromJson(Map<String, dynamic> json) => _$ImageUrlsFromJson(json);

  Map<String, dynamic> toJson() => _$ImageUrlsToJson(this);
}
