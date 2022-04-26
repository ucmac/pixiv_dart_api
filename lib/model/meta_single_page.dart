import 'package:json_annotation/json_annotation.dart';

part 'meta_single_page.g.dart';

@JsonSerializable(explicitToJson: true)
class MetaSinglePage {
  @JsonKey(name: 'original_image_url')
  String? originalImageUrl;

  MetaSinglePage(this.originalImageUrl);

  factory MetaSinglePage.fromJson(Map<String, dynamic> json) => _$MetaSinglePageFromJson(json);

  Map<String, dynamic> toJson() => _$MetaSinglePageToJson(this);
}
