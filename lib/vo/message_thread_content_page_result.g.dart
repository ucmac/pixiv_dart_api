// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_thread_content_page_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageThreadContentPageResult _$MessageThreadContentPageResultFromJson(
        Map<String, dynamic> json) =>
    MessageThreadContentPageResult(
      json['error'] as bool,
      json['message'] as String,
      MessageThreadContentBody.fromJson(json['body'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MessageThreadContentPageResultToJson(
        MessageThreadContentPageResult instance) =>
    <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
      'body': instance.body.toJson(),
    };

MessageThreadContentBody _$MessageThreadContentBodyFromJson(
        Map<String, dynamic> json) =>
    MessageThreadContentBody(
      json['total'] as String,
      (json['message_thread_contents'] as List<dynamic>)
          .map((e) => MessageThreadContent.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['next_url'] as String?,
    );

Map<String, dynamic> _$MessageThreadContentBodyToJson(
        MessageThreadContentBody instance) =>
    <String, dynamic>{
      'total': instance.total,
      'message_thread_contents':
          instance.messageThreadContents.map((e) => e.toJson()).toList(),
      'next_url': instance.nextUrl,
    };
