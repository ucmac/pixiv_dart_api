// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_page_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserPageResult _$UserPageResultFromJson(Map<String, dynamic> json) => UserPageResult(
      (json['user_previews'] as List<dynamic>).map((e) => UserPreview.fromJson(e as Map<String, dynamic>)).toList(),
      json['next_url'] as String?,
    );

Map<String, dynamic> _$UserPageResultToJson(UserPageResult instance) => <String, dynamic>{
      'user_previews': instance.userPreviews.map((e) => e.toJson()).toList(),
      'next_url': instance.nextUrl,
    };
