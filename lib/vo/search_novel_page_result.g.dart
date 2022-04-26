// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_novel_page_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchNovelPageResult _$SearchNovelPageResultFromJson(Map<String, dynamic> json) => SearchNovelPageResult(
      (json['novels'] as List<dynamic>).map((e) => Novel.fromJson(e as Map<String, dynamic>)).toList(),
      json['next_url'] as String?,
      json['search_span_limit'] as int,
    );

Map<String, dynamic> _$SearchNovelPageResultToJson(SearchNovelPageResult instance) => <String, dynamic>{
      'novels': instance.novels.map((e) => e.toJson()).toList(),
      'next_url': instance.nextUrl,
      'search_span_limit': instance.searchSpanLimit,
    };
