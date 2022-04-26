// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trending_tag_list_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrendingTagListResult _$TrendingTagListResultFromJson(Map<String, dynamic> json) => TrendingTagListResult(
      (json['trend_tags'] as List<dynamic>).map((e) => TrendTag.fromJson(e as Map<String, dynamic>)).toList(),
    );

Map<String, dynamic> _$TrendingTagListResultToJson(TrendingTagListResult instance) => <String, dynamic>{
      'trend_tags': instance.trendTags.map((e) => e.toJson()).toList(),
    };

TrendTag _$TrendTagFromJson(Map<String, dynamic> json) => TrendTag(
      json['tag'] as String,
      json['translated_name'] as String?,
      Illust.fromJson(json['illust'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TrendTagToJson(TrendTag instance) => <String, dynamic>{
      'tag': instance.tag,
      'translated_name': instance.translatedName,
      'illust': instance.illust.toJson(),
    };
