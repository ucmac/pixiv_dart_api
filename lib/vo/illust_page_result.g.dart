// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'illust_page_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IllustPageResult _$IllustPageResultFromJson(Map<String, dynamic> json) => IllustPageResult(
      (json['illusts'] as List<dynamic>).map((e) => Illust.fromJson(e as Map<String, dynamic>)).toList(),
      json['next_url'] as String?,
    );

Map<String, dynamic> _$IllustPageResultToJson(IllustPageResult instance) => <String, dynamic>{
      'illusts': instance.illusts.map((e) => e.toJson()).toList(),
      'next_url': instance.nextUrl,
    };
