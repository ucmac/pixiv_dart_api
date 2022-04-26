import 'package:json_annotation/json_annotation.dart';

part 'ugoira_metadata_result.g.dart';

@JsonSerializable(explicitToJson: true)
class UgoiraMetadataResult {
  @JsonKey(name: 'ugoira_metadata')
  UgoiraMetadataContent ugoiraMetadata;

  UgoiraMetadataResult(this.ugoiraMetadata);

  factory UgoiraMetadataResult.fromJson(Map<String, dynamic> json) => _$UgoiraMetadataResultFromJson(json);

  Map<String, dynamic> toJson() => _$UgoiraMetadataResultToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UgoiraMetadataContent {
  @JsonKey(name: 'zip_urls')
  ZipUrls zipUrls;
  List<Frame> frames;

  UgoiraMetadataContent(this.zipUrls, this.frames);

  factory UgoiraMetadataContent.fromJson(Map<String, dynamic> json) => _$UgoiraMetadataContentFromJson(json);

  Map<String, dynamic> toJson() => _$UgoiraMetadataContentToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ZipUrls {
  String medium;

  ZipUrls(this.medium);

  factory ZipUrls.fromJson(Map<String, dynamic> json) => _$ZipUrlsFromJson(json);

  Map<String, dynamic> toJson() => _$ZipUrlsToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Frame {
  String file;
  int delay;

  Frame(this.file, this.delay);

  factory Frame.fromJson(Map<String, dynamic> json) => _$FrameFromJson(json);

  Map<String, dynamic> toJson() => _$FrameToJson(this);
}
