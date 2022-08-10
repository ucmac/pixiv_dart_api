// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_thread_content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageThreadContent _$MessageThreadContentFromJson(
        Map<String, dynamic> json) =>
    MessageThreadContent(
      json['content_id'] as String,
      json['thread_id'] as String,
      MessageContentUser.fromJson(json['user'] as Map<String, dynamic>),
      json['created_at'] as String,
      MessageContent.fromJson(json['content'] as Map<String, dynamic>),
      json['is_complete_user'] as bool,
    );

Map<String, dynamic> _$MessageThreadContentToJson(
        MessageThreadContent instance) =>
    <String, dynamic>{
      'content_id': instance.contentId,
      'thread_id': instance.threadId,
      'user': instance.user.toJson(),
      'created_at': instance.createAt,
      'content': instance.content.toJson(),
      'is_complete_user': instance.isCompleteUser,
    };

MessageContentUser _$MessageContentUserFromJson(Map<String, dynamic> json) =>
    MessageContentUser(
      json['user_id'] as String,
      json['user_name'] as String,
      MessageContentUserIconUrl.fromJson(
          json['icon_url'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MessageContentUserToJson(MessageContentUser instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'user_name': instance.userName,
      'icon_url': instance.iconUrl.toJson(),
    };

MessageContentUserIconUrl _$MessageContentUserIconUrlFromJson(
        Map<String, dynamic> json) =>
    MessageContentUserIconUrl(
      json['main_s'] as String,
    );

Map<String, dynamic> _$MessageContentUserIconUrlToJson(
        MessageContentUserIconUrl instance) =>
    <String, dynamic>{
      'main_s': instance.mainS,
    };

MessageContent _$MessageContentFromJson(Map<String, dynamic> json) =>
    MessageContent(
      json['type'] as String,
      json['text'] as String?,
      json['is_starred'] as bool?,
      json['image_urls'] == null
          ? null
          : MessageContentImageUrls.fromJson(
              json['image_urls'] as Map<String, dynamic>),
      json['width'] as String?,
      json['height'] as String?,
    );

Map<String, dynamic> _$MessageContentToJson(MessageContent instance) =>
    <String, dynamic>{
      'type': instance.type,
      'text': instance.text,
      'is_starred': instance.isStarred,
      'image_urls': instance.imageUrls?.toJson(),
      'width': instance.width,
      'height': instance.height,
    };

MessageContentImageUrls _$MessageContentImageUrlsFromJson(
        Map<String, dynamic> json) =>
    MessageContentImageUrls(
      json['100x100'] as String,
      json['200x200'] as String,
      json['400x400'] as String,
      json['600x600'] as String,
      json['big'] as String,
    );

Map<String, dynamic> _$MessageContentImageUrlsToJson(
        MessageContentImageUrls instance) =>
    <String, dynamic>{
      '100x100': instance.px100x100,
      '200x200': instance.px200x200,
      '400x400': instance.px400x400,
      '600x600': instance.px600x600,
      'big': instance.big,
    };
