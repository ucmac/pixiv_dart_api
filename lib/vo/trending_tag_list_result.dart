import 'package:json_annotation/json_annotation.dart';

import '../model/illust.dart';

part 'trending_tag_list_result.g.dart';

@JsonSerializable(explicitToJson: true)
class TrendingTagListResult {
  @JsonKey(name: 'trend_tags')
  List<TrendTag> trendTags;

  TrendingTagListResult(this.trendTags);

  factory TrendingTagListResult.fromJson(Map<String, dynamic> json) => _$TrendingTagListResultFromJson(json);

  Map<String, dynamic> toJson() => _$TrendingTagListResultToJson(this);
}

@JsonSerializable(explicitToJson: true)
class TrendTag {
  String tag;
  @JsonKey(name: 'translated_name')
  String? translatedName;
  Illust illust;

  TrendTag(this.tag, this.translatedName, this.illust);

  factory TrendTag.fromJson(Map<String, dynamic> json) => _$TrendTagFromJson(json);

  Map<String, dynamic> toJson() => _$TrendTagToJson(this);
}
