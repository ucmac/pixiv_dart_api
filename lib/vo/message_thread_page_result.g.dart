// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_thread_page_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageThreadPageResult _$MessageThreadPageResultFromJson(
        Map<String, dynamic> json) =>
    MessageThreadPageResult(
      json['error'] as bool,
      json['message'] as String,
      MessageThreadBody.fromJson(json['body'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MessageThreadPageResultToJson(
        MessageThreadPageResult instance) =>
    <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
      'body': instance.body.toJson(),
    };

MessageThreadBody _$MessageThreadBodyFromJson(Map<String, dynamic> json) =>
    MessageThreadBody(
      json['total'] as int,
      (json['message_threads'] as List<dynamic>)
          .map((e) => MessageThread.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['next_url'] as String?,
    );

Map<String, dynamic> _$MessageThreadBodyToJson(MessageThreadBody instance) =>
    <String, dynamic>{
      'total': instance.total,
      'message_threads':
          instance.messageThreads.map((e) => e.toJson()).toList(),
      'next_url': instance.nextUrl,
    };
