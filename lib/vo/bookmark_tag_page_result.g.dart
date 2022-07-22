// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookmark_tag_page_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookmarkTagPageResult _$BookmarkTagPageResultFromJson(
        Map<String, dynamic> json) =>
    BookmarkTagPageResult(
      (json['bookmark_tags'] as List<dynamic>)
          .map((e) => BookmarkTag.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['next_url'] as String?,
    );

Map<String, dynamic> _$BookmarkTagPageResultToJson(
        BookmarkTagPageResult instance) =>
    <String, dynamic>{
      'bookmark_tags': instance.bookmarkTags.map((e) => e.toJson()).toList(),
      'next_url': instance.nextUrl,
    };
