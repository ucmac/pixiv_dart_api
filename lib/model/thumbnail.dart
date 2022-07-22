import 'package:json_annotation/json_annotation.dart';

part 'thumbnail.g.dart';

@JsonSerializable(explicitToJson: true)
class Thumbnail {
  ThumbnailUrl sq800;
  ThumbnailUrl w160;
  ThumbnailUrl w400;
  ThumbnailUrl w1280;
  ThumbnailUrl original;

  Thumbnail(this.sq800, this.w160, this.w400, this.w1280, this.original);

  factory Thumbnail.fromJson(Map<String, dynamic> json) => _$ThumbnailFromJson(json);

  Map<String, dynamic> toJson() => _$ThumbnailToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ThumbnailUrl {
  String url;

  ThumbnailUrl(this.url);

  factory ThumbnailUrl.fromJson(Map<String, dynamic> json) => _$ThumbnailUrlFromJson(json);

  Map<String, dynamic> toJson() => _$ThumbnailUrlToJson(this);
}
