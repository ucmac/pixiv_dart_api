import 'package:json_annotation/json_annotation.dart';
import 'package:pixiv_dart_api/model/thumbnail.dart';

part 'live_detail_result.g.dart';

@JsonSerializable(explicitToJson: true)
class LiveDetailResult {
  LiveDetailData data;
  String rand;

  LiveDetailResult(this.data, this.rand);

  factory LiveDetailResult.fromJson(Map<String, dynamic> json) => _$LiveDetailResultFromJson(json);

  Map<String, dynamic> toJson() => _$LiveDetailResultToJson(this);
}

@JsonSerializable(explicitToJson: true)
class LiveDetailData {
  String id;
  @JsonKey(name: 'created_at')
  String createdAt;
  @JsonKey(name: 'finished_at')
  String? finishedAt;
  LiveUser user;
  LiveOwner owner;

  ///合作者 也是在直播的
  List<LivePerformer> performers;
  String name;
  String description;
  ///描述的分片
  @JsonKey(name: 'description_fragments')
  List<LiveDescriptionFragment> descriptionFragments;

  ///单人
  @JsonKey(name: 'is_single')
  bool isSingle;

  ///多人
  @JsonKey(name: 'is_adult')
  bool isAdult;
  @JsonKey(name: 'is_r15')
  bool isR15;
  @JsonKey(name: 'is_r18')
  bool isR18;

  ///正在广播
  @JsonKey(name: 'is_broadcasting')
  bool isBroadcasting;
  String publicity;
  @JsonKey(name: 'is_closed')
  bool isClosed;

  ///screencast webcam
  String mode;
  String server;
  @JsonKey(name: 'channel_id')
  String channelId;
  String source;
  @JsonKey(name: 'is_enabled_mic_input')
  bool isEnabledMicInput;
  @JsonKey(name: 'is_enabled_gifting')
  bool isEnabledGifting;
  @JsonKey(name: 'is_enabled_chat')
  bool isEnabledChat;
  Thumbnail? thumbnail;
  @JsonKey(name: 'member_count')
  int? memberCount;
  @JsonKey(name: 'audience_count')
  int audienceCount;
  @JsonKey(name: 'total_audience_count')
  int totalAudienceCount;
  @JsonKey(name: 'heart_count')
  int heartCount;
  @JsonKey(name: 'chat_count')
  int chatCount;
  @JsonKey(name: 'performer_count')
  int performerCount;

  LiveDetailData(
    this.id,
    this.createdAt,
    this.finishedAt,
    this.user,
    this.owner,
    this.performers,
    this.name,
    this.description,
    this.descriptionFragments,
    this.isSingle,
    this.isAdult,
    this.isR15,
    this.isR18,
    this.isBroadcasting,
    this.publicity,
    this.isClosed,
    this.mode,
    this.server,
    this.channelId,
    this.source,
    this.isEnabledMicInput,
    this.isEnabledGifting,
    this.isEnabledChat,
    this.thumbnail,
    this.memberCount,
    this.audienceCount,
    this.totalAudienceCount,
    this.heartCount,
    this.chatCount,
    this.performerCount,
  );

  factory LiveDetailData.fromJson(Map<String, dynamic> json) => _$LiveDetailDataFromJson(json);

  Map<String, dynamic> toJson() => _$LiveDetailDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class LiveUser {
  int id;

  @JsonKey(name: 'pixiv_user_id')
  int pixivUserId;

  @JsonKey(name: 'unique_name')
  String uniqueName;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'icon')
  LiveIcon icon;

  @JsonKey(name: 'following')
  bool following;

  @JsonKey(name: 'followed')
  bool followed;

  @JsonKey(name: 'blocking')
  bool blocking;

  LiveUser(this.id, this.pixivUserId, this.uniqueName, this.name, this.icon, this.following, this.followed, this.blocking);

  factory LiveUser.fromJson(Map<String, dynamic> json) => _$LiveUserFromJson(json);

  Map<String, dynamic> toJson() => _$LiveUserToJson(this);
}

@JsonSerializable(explicitToJson: true)
class LiveIcon {
  int id;
  String type;
  LiveIconColor color;

  LiveIconPhoto photo;

  LiveIcon(this.id, this.type, this.color, this.photo);

  factory LiveIcon.fromJson(Map<String, dynamic> json) => _$LiveIconFromJson(json);

  Map<String, dynamic> toJson() => _$LiveIconToJson(this);
}

@JsonSerializable(explicitToJson: true)
class LiveIconColor {
  String hex;
  int r;
  int g;
  int b;

  LiveIconColor(this.hex, this.r, this.g, this.b);

  factory LiveIconColor.fromJson(Map<String, dynamic> json) => _$LiveIconColorFromJson(json);

  Map<String, dynamic> toJson() => _$LiveIconColorToJson(this);
}

@JsonSerializable(explicitToJson: true)
class LiveIconPhoto {
  LiveIconPhotoImage original;
  LiveIconPhotoImage sq180;
  LiveIconPhotoImage pxsq180;
  LiveIconPhotoImage w540;
  LiveIconPhotoImage pxw540;
  LiveIconPhotoImage sq60;
  LiveIconPhotoImage pxsq60;
  LiveIconPhotoImage sq120;
  LiveIconPhotoImage pxsq120;
  LiveIconPhotoImage w240;
  LiveIconPhotoImage pxw240;

  LiveIconPhoto(
    this.original,
    this.sq180,
    this.pxsq180,
    this.w540,
    this.pxw540,
    this.sq60,
    this.pxsq60,
    this.sq120,
    this.pxsq120,
    this.w240,
    this.pxw240,
  );

  factory LiveIconPhoto.fromJson(Map<String, dynamic> json) => _$LiveIconPhotoFromJson(json);

  Map<String, dynamic> toJson() => _$LiveIconPhotoToJson(this);
}

@JsonSerializable(explicitToJson: true)
class LiveIconPhotoImage {
  int width;
  int height;
  String url;
  String url2x;

  LiveIconPhotoImage(this.width, this.height, this.url, this.url2x);

  factory LiveIconPhotoImage.fromJson(Map<String, dynamic> json) => _$LiveIconPhotoImageFromJson(json);

  Map<String, dynamic> toJson() => _$LiveIconPhotoImageToJson(this);
}

@JsonSerializable(explicitToJson: true)
class LiveOwner {
  LiveUser user;
  Thumbnail thumbnail;
  @JsonKey(name: 'client_id')
  String clientId;
  @JsonKey(name: 'hls_movie')
  LiveHlsMovie hlsMovie;

  ///开麦
  @JsonKey(name: 'is_enabled_mic_input')
  bool isEnabledMicInput;

  LiveOwner(this.user, this.thumbnail, this.clientId, this.hlsMovie, this.isEnabledMicInput);

  factory LiveOwner.fromJson(Map<String, dynamic> json) => _$LiveOwnerFromJson(json);

  Map<String, dynamic> toJson() => _$LiveOwnerToJson(this);
}

@JsonSerializable(explicitToJson: true)
class LivePerformer {
  LiveUser user;
  Thumbnail thumbnail;
  @JsonKey(name: 'client_id')
  String clientId;
  @JsonKey(name: 'hls_movie')
  LiveHlsMovie hlsMovie;

  ///开麦
  @JsonKey(name: 'is_enabled_mic_input')
  bool isEnabledMicInput;

  LivePerformer(this.user, this.thumbnail, this.clientId, this.hlsMovie, this.isEnabledMicInput);

  factory LivePerformer.fromJson(Map<String, dynamic> json) => _$LivePerformerFromJson(json);

  Map<String, dynamic> toJson() => _$LivePerformerToJson(this);
}

@JsonSerializable(explicitToJson: true)
class LiveHlsMovie {
  String url;

  LiveHlsMovie(this.url);

  factory LiveHlsMovie.fromJson(Map<String, dynamic> json) => _$LiveHlsMovieFromJson(json);

  Map<String, dynamic> toJson() => _$LiveHlsMovieToJson(this);
}

@JsonSerializable(explicitToJson: true)
class LiveDescriptionFragment {
  String type;
  String body;
  @JsonKey(name: 'normalized_body')
  String normalizedBody;

  LiveDescriptionFragment(this.type, this.body, this.normalizedBody);

  factory LiveDescriptionFragment.fromJson(Map<String, dynamic> json) => _$LiveDescriptionFragmentFromJson(json);

  Map<String, dynamic> toJson() => _$LiveDescriptionFragmentToJson(this);
}
