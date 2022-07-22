// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'novel_page_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NovelPageResult _$NovelPageResultFromJson(Map<String, dynamic> json) =>
    NovelPageResult(
      (json['novels'] as List<dynamic>)
          .map((e) => Novel.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['nextUrl'] as String?,
    );

Map<String, dynamic> _$NovelPageResultToJson(NovelPageResult instance) =>
    <String, dynamic>{
      'novels': instance.novels.map((e) => e.toJson()).toList(),
      'nextUrl': instance.nextUrl,
    };
