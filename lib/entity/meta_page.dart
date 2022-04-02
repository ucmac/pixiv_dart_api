import 'package:json_annotation/json_annotation.dart';

import 'image_urls.dart';

part 'meta_page.g.dart';

@JsonSerializable(explicitToJson: true)
class MetaPage {
  @JsonKey(name: 'image_urls')
  ImageUrls imageUrls;

  MetaPage(this.imageUrls);

  factory MetaPage.fromJson(Map<String, dynamic> json) => _$MetaPageFromJson(json);

  Map<String, dynamic> toJson() => _$MetaPageToJson(this);
}
