// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_thread.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageThread _$MessageThreadFromJson(Map<String, dynamic> json) =>
    MessageThread(
      json['thread_id'] as String,
      json['modified_at'] as String,
      json['unread_num'] as String,
      json['member_num'] as String,
      json['latest_content'] as String,
      json['is_pair'] as bool,
      json['thread_name'] as String,
      MessageThreadIconUrl.fromJson(json['icon_url'] as Map<String, dynamic>),
      json['followed'] as bool,
      json['is_official'] as bool,
      json['is_mendako'] as bool,
      json['is_active_thread'] as bool,
      json['is_fanbox_subscriber'] as bool,
    );

Map<String, dynamic> _$MessageThreadToJson(MessageThread instance) =>
    <String, dynamic>{
      'thread_id': instance.threadId,
      'modified_at': instance.modifiedAt,
      'unread_num': instance.unreadNum,
      'member_num': instance.memberNum,
      'latest_content': instance.latestContent,
      'is_pair': instance.isPair,
      'thread_name': instance.threadName,
      'icon_url': instance.iconUrl.toJson(),
      'followed': instance.followed,
      'is_official': instance.isOfficial,
      'is_mendako': instance.isMendako,
      'is_active_thread': instance.isActiveThread,
      'is_fanbox_subscriber': instance.isFanboxSubscriber,
    };

MessageThreadIconUrl _$MessageThreadIconUrlFromJson(
        Map<String, dynamic> json) =>
    MessageThreadIconUrl(
      json['100x100'] as String,
    );

Map<String, dynamic> _$MessageThreadIconUrlToJson(
        MessageThreadIconUrl instance) =>
    <String, dynamic>{
      '100x100': instance.px100x100,
    };
