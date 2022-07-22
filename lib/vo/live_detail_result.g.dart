// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'live_detail_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LiveDetailResult _$LiveDetailResultFromJson(Map<String, dynamic> json) =>
    LiveDetailResult(
      json['id'] as String,
      json['create_at'] as String,
      json['finished_at'] as String?,
      User.fromJson(json['user'] as Map<String, dynamic>),
      LiveOwner.fromJson(json['owner'] as Map<String, dynamic>),
      (json['performers'] as List<dynamic>)
          .map((e) => LivePerformer.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['name'] as String,
      json['description'] as String,
      (json['description_fragments'] as List<dynamic>)
          .map((e) =>
              LiveDescriptionFragment.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['is_single'] as bool,
      json['is_adult'] as bool,
      json['is_r15'] as bool,
      json['is_r18'] as bool,
      json['is_broadcasting'] as bool,
      json['publicity'] as String,
      json['is_closed'] as bool,
      json['mode'] as String,
      json['server'] as String,
      json['channel_id'] as String,
      json['source'] as String,
      json['is_enabled_mic_input'] as bool,
      json['is_enabled_gifting'] as bool,
      json['is_enabled_chat'] as bool,
      Thumbnail.fromJson(json['thumbnail'] as Map<String, dynamic>),
      json['member_count'] as int,
      json['audience_count'] as int,
      json['total_audience_count'] as int,
      json['heart_count'] as int,
      json['chat_count'] as int,
      json['performer_count'] as int,
      json['rand'] as String,
    );

Map<String, dynamic> _$LiveDetailResultToJson(LiveDetailResult instance) =>
    <String, dynamic>{
      'id': instance.id,
      'create_at': instance.createAt,
      'finished_at': instance.finishedAt,
      'user': instance.user.toJson(),
      'owner': instance.owner.toJson(),
      'performers': instance.performers.map((e) => e.toJson()).toList(),
      'name': instance.name,
      'description': instance.description,
      'description_fragments':
          instance.descriptionFragments.map((e) => e.toJson()).toList(),
      'is_single': instance.isSingle,
      'is_adult': instance.isAdult,
      'is_r15': instance.isR15,
      'is_r18': instance.isR18,
      'is_broadcasting': instance.isBroadcasting,
      'publicity': instance.publicity,
      'is_closed': instance.isClosed,
      'mode': instance.mode,
      'server': instance.server,
      'channel_id': instance.channelId,
      'source': instance.source,
      'is_enabled_mic_input': instance.isEnabledMicInput,
      'is_enabled_gifting': instance.isEnabledGifting,
      'is_enabled_chat': instance.isEnabledChat,
      'thumbnail': instance.thumbnail.toJson(),
      'member_count': instance.memberCount,
      'audience_count': instance.audienceCount,
      'total_audience_count': instance.totalAudienceCount,
      'heart_count': instance.heartCount,
      'chat_count': instance.chatCount,
      'performer_count': instance.performerCount,
      'rand': instance.rand,
    };

LiveOwner _$LiveOwnerFromJson(Map<String, dynamic> json) => LiveOwner(
      User.fromJson(json['user'] as Map<String, dynamic>),
      Thumbnail.fromJson(json['thumbnail'] as Map<String, dynamic>),
      json['client_id'] as String,
      json['is_enabled_mic_input'] as bool,
    );

Map<String, dynamic> _$LiveOwnerToJson(LiveOwner instance) => <String, dynamic>{
      'user': instance.user.toJson(),
      'thumbnail': instance.thumbnail.toJson(),
      'client_id': instance.clientId,
      'is_enabled_mic_input': instance.isEnabledMicInput,
    };

LivePerformer _$LivePerformerFromJson(Map<String, dynamic> json) =>
    LivePerformer(
      User.fromJson(json['user'] as Map<String, dynamic>),
      Thumbnail.fromJson(json['thumbnail'] as Map<String, dynamic>),
      json['client_id'] as String,
      LiveHlsMovie.fromJson(json['hlsMovie'] as Map<String, dynamic>),
      json['is_enabled_mic_input'] as bool,
    );

Map<String, dynamic> _$LivePerformerToJson(LivePerformer instance) =>
    <String, dynamic>{
      'user': instance.user.toJson(),
      'thumbnail': instance.thumbnail.toJson(),
      'client_id': instance.clientId,
      'hlsMovie': instance.hlsMovie.toJson(),
      'is_enabled_mic_input': instance.isEnabledMicInput,
    };

LiveHlsMovie _$LiveHlsMovieFromJson(Map<String, dynamic> json) => LiveHlsMovie(
      json['url'] as String,
    );

Map<String, dynamic> _$LiveHlsMovieToJson(LiveHlsMovie instance) =>
    <String, dynamic>{
      'url': instance.url,
    };

LiveDescriptionFragment _$LiveDescriptionFragmentFromJson(
        Map<String, dynamic> json) =>
    LiveDescriptionFragment(
      json['type'] as String,
      json['body'] as String,
      json['normalizedBody'] as String,
    );

Map<String, dynamic> _$LiveDescriptionFragmentToJson(
        LiveDescriptionFragment instance) =>
    <String, dynamic>{
      'type': instance.type,
      'body': instance.body,
      'normalizedBody': instance.normalizedBody,
    };
