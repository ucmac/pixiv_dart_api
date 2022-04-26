// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_page_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentPageResult _$CommentPageResultFromJson(Map<String, dynamic> json) => CommentPageResult(
      (json['comments'] as List<dynamic>).map((e) => Comment.fromJson(e as Map<String, dynamic>)).toList(),
      json['next_url'] as String?,
    );

Map<String, dynamic> _$CommentPageResultToJson(CommentPageResult instance) => <String, dynamic>{
      'comments': instance.comments.map((e) => e.toJson()).toList(),
      'next_url': instance.nextUrl,
    };
