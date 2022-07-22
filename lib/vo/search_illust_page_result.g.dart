// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_illust_page_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchIllustPageResult _$SearchIllustPageResultFromJson(
        Map<String, dynamic> json) =>
    SearchIllustPageResult(
      (json['illusts'] as List<dynamic>)
          .map((e) => Illust.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['next_url'] as String?,
      json['search_span_limit'] as int,
    );

Map<String, dynamic> _$SearchIllustPageResultToJson(
        SearchIllustPageResult instance) =>
    <String, dynamic>{
      'illusts': instance.illusts.map((e) => e.toJson()).toList(),
      'next_url': instance.nextUrl,
      'search_span_limit': instance.searchSpanLimit,
    };
