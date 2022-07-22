// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookmark_detail_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookmarkDetailResult _$BookmarkDetailResultFromJson(
        Map<String, dynamic> json) =>
    BookmarkDetailResult(
      json['is_bookmarked'] as bool,
      (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      json['restrict'] as String,
    );

Map<String, dynamic> _$BookmarkDetailResultToJson(
        BookmarkDetailResult instance) =>
    <String, dynamic>{
      'is_bookmarked': instance.isBookmarked,
      'tags': instance.tags,
      'restrict': instance.restrict,
    };
