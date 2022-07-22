// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'live.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Live _$LiveFromJson(Map<String, dynamic> json) => Live(
      json['id'] as String,
      json['create_at'] as String,
      NestedUser.fromJson(json['owner'] as Map<String, dynamic>),
      (json['performers'] as List<dynamic>)
          .map((e) => NestedUser.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['name'] as String,
      json['is_single'] as bool,
      json['is_adult'] as bool,
      json['is_r15'] as bool,
      json['is_r18'] as bool,
      json['publicity'] as String,
      json['is_closed'] as bool,
      json['mode'] as String,
      json['server'] as String,
      json['channel_id'] as String,
      json['is_enabled_mic_input'] as bool,
      json['thumbnail_image_url'] as String,
      json['member_count'] as int,
      json['total_audience_count'] as int,
      json['performer_count'] as int,
      json['is_muted'] as bool,
    );

Map<String, dynamic> _$LiveToJson(Live instance) => <String, dynamic>{
      'id': instance.id,
      'create_at': instance.createAt,
      'owner': instance.owner.toJson(),
      'performers': instance.performers.map((e) => e.toJson()).toList(),
      'name': instance.name,
      'is_single': instance.isSingle,
      'is_adult': instance.isAdult,
      'is_r15': instance.isR15,
      'is_r18': instance.isR18,
      'publicity': instance.publicity,
      'is_closed': instance.isClosed,
      'mode': instance.mode,
      'server': instance.server,
      'channel_id': instance.channelId,
      'is_enabled_mic_input': instance.isEnabledMicInput,
      'thumbnail_image_url': instance.thumbnailImageUrl,
      'member_count': instance.memberCount,
      'total_audience_count': instance.totalAudienceCount,
      'performer_count': instance.performerCount,
      'is_muted': instance.isMuted,
    };

NestedUser _$NestedUserFromJson(Map<String, dynamic> json) => NestedUser(
      User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NestedUserToJson(NestedUser instance) =>
    <String, dynamic>{
      'user': instance.user.toJson(),
    };
