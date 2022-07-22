// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'live_page_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LivePageResult _$LivePageResultFromJson(Map<String, dynamic> json) =>
    LivePageResult(
      (json['lives'] as List<dynamic>)
          .map((e) => Live.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['next_url'] as String?,
    );

Map<String, dynamic> _$LivePageResultToJson(LivePageResult instance) =>
    <String, dynamic>{
      'lives': instance.lives.map((e) => e.toJson()).toList(),
      'next_url': instance.nextUrl,
    };
