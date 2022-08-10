// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'live_detail_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LiveDetailResult _$LiveDetailResultFromJson(Map<String, dynamic> json) =>
    LiveDetailResult(
      LiveDetailData.fromJson(json['data'] as Map<String, dynamic>),
      json['rand'] as String,
    );

Map<String, dynamic> _$LiveDetailResultToJson(LiveDetailResult instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
      'rand': instance.rand,
    };

LiveDetailData _$LiveDetailDataFromJson(Map<String, dynamic> json) =>
    LiveDetailData(
      json['id'] as String,
      json['created_at'] as String,
      json['finished_at'] as String?,
      LiveUser.fromJson(json['user'] as Map<String, dynamic>),
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
      json['thumbnail'] == null
          ? null
          : Thumbnail.fromJson(json['thumbnail'] as Map<String, dynamic>),
      json['member_count'] as int?,
      json['audience_count'] as int,
      json['total_audience_count'] as int,
      json['heart_count'] as int,
      json['chat_count'] as int,
      json['performer_count'] as int,
    );

Map<String, dynamic> _$LiveDetailDataToJson(LiveDetailData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt,
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
      'thumbnail': instance.thumbnail?.toJson(),
      'member_count': instance.memberCount,
      'audience_count': instance.audienceCount,
      'total_audience_count': instance.totalAudienceCount,
      'heart_count': instance.heartCount,
      'chat_count': instance.chatCount,
      'performer_count': instance.performerCount,
    };

LiveUser _$LiveUserFromJson(Map<String, dynamic> json) => LiveUser(
      json['id'] as int,
      json['pixiv_user_id'] as int,
      json['unique_name'] as String,
      json['name'] as String,
      LiveIcon.fromJson(json['icon'] as Map<String, dynamic>),
      json['following'] as bool,
      json['followed'] as bool,
      json['blocking'] as bool,
    );

Map<String, dynamic> _$LiveUserToJson(LiveUser instance) => <String, dynamic>{
      'id': instance.id,
      'pixiv_user_id': instance.pixivUserId,
      'unique_name': instance.uniqueName,
      'name': instance.name,
      'icon': instance.icon.toJson(),
      'following': instance.following,
      'followed': instance.followed,
      'blocking': instance.blocking,
    };

LiveIcon _$LiveIconFromJson(Map<String, dynamic> json) => LiveIcon(
      json['id'] as int,
      json['type'] as String,
      LiveIconColor.fromJson(json['color'] as Map<String, dynamic>),
      LiveIconPhoto.fromJson(json['photo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LiveIconToJson(LiveIcon instance) => <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'color': instance.color.toJson(),
      'photo': instance.photo.toJson(),
    };

LiveIconColor _$LiveIconColorFromJson(Map<String, dynamic> json) =>
    LiveIconColor(
      json['hex'] as String,
      json['r'] as int,
      json['g'] as int,
      json['b'] as int,
    );

Map<String, dynamic> _$LiveIconColorToJson(LiveIconColor instance) =>
    <String, dynamic>{
      'hex': instance.hex,
      'r': instance.r,
      'g': instance.g,
      'b': instance.b,
    };

LiveIconPhoto _$LiveIconPhotoFromJson(Map<String, dynamic> json) =>
    LiveIconPhoto(
      LiveIconPhotoImage.fromJson(json['original'] as Map<String, dynamic>),
      LiveIconPhotoImage.fromJson(json['sq180'] as Map<String, dynamic>),
      LiveIconPhotoImage.fromJson(json['pxsq180'] as Map<String, dynamic>),
      LiveIconPhotoImage.fromJson(json['w540'] as Map<String, dynamic>),
      LiveIconPhotoImage.fromJson(json['pxw540'] as Map<String, dynamic>),
      LiveIconPhotoImage.fromJson(json['sq60'] as Map<String, dynamic>),
      LiveIconPhotoImage.fromJson(json['pxsq60'] as Map<String, dynamic>),
      LiveIconPhotoImage.fromJson(json['sq120'] as Map<String, dynamic>),
      LiveIconPhotoImage.fromJson(json['pxsq120'] as Map<String, dynamic>),
      LiveIconPhotoImage.fromJson(json['w240'] as Map<String, dynamic>),
      LiveIconPhotoImage.fromJson(json['pxw240'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LiveIconPhotoToJson(LiveIconPhoto instance) =>
    <String, dynamic>{
      'original': instance.original.toJson(),
      'sq180': instance.sq180.toJson(),
      'pxsq180': instance.pxsq180.toJson(),
      'w540': instance.w540.toJson(),
      'pxw540': instance.pxw540.toJson(),
      'sq60': instance.sq60.toJson(),
      'pxsq60': instance.pxsq60.toJson(),
      'sq120': instance.sq120.toJson(),
      'pxsq120': instance.pxsq120.toJson(),
      'w240': instance.w240.toJson(),
      'pxw240': instance.pxw240.toJson(),
    };

LiveIconPhotoImage _$LiveIconPhotoImageFromJson(Map<String, dynamic> json) =>
    LiveIconPhotoImage(
      json['width'] as int,
      json['height'] as int,
      json['url'] as String,
      json['url2x'] as String,
    );

Map<String, dynamic> _$LiveIconPhotoImageToJson(LiveIconPhotoImage instance) =>
    <String, dynamic>{
      'width': instance.width,
      'height': instance.height,
      'url': instance.url,
      'url2x': instance.url2x,
    };

LiveOwner _$LiveOwnerFromJson(Map<String, dynamic> json) => LiveOwner(
      LiveUser.fromJson(json['user'] as Map<String, dynamic>),
      Thumbnail.fromJson(json['thumbnail'] as Map<String, dynamic>),
      json['client_id'] as String,
      LiveHlsMovie.fromJson(json['hls_movie'] as Map<String, dynamic>),
      json['is_enabled_mic_input'] as bool,
    );

Map<String, dynamic> _$LiveOwnerToJson(LiveOwner instance) => <String, dynamic>{
      'user': instance.user.toJson(),
      'thumbnail': instance.thumbnail.toJson(),
      'client_id': instance.clientId,
      'hls_movie': instance.hlsMovie.toJson(),
      'is_enabled_mic_input': instance.isEnabledMicInput,
    };

LivePerformer _$LivePerformerFromJson(Map<String, dynamic> json) =>
    LivePerformer(
      LiveUser.fromJson(json['user'] as Map<String, dynamic>),
      Thumbnail.fromJson(json['thumbnail'] as Map<String, dynamic>),
      json['client_id'] as String,
      LiveHlsMovie.fromJson(json['hls_movie'] as Map<String, dynamic>),
      json['is_enabled_mic_input'] as bool,
    );

Map<String, dynamic> _$LivePerformerToJson(LivePerformer instance) =>
    <String, dynamic>{
      'user': instance.user.toJson(),
      'thumbnail': instance.thumbnail.toJson(),
      'client_id': instance.clientId,
      'hls_movie': instance.hlsMovie.toJson(),
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
      json['normalized_body'] as String,
    );

Map<String, dynamic> _$LiveDescriptionFragmentToJson(
        LiveDescriptionFragment instance) =>
    <String, dynamic>{
      'type': instance.type,
      'body': instance.body,
      'normalized_body': instance.normalizedBody,
    };
