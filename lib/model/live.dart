import 'package:json_annotation/json_annotation.dart';

import 'user.dart';

part 'live.g.dart';

@JsonSerializable(explicitToJson: true)
class Live {
  String id;
  @JsonKey(name: 'create_at')
  String createAt;
  NestedUser owner;
  List<NestedUser> performers;
  String name;
  ///单人
  @JsonKey(name: 'is_single')
  bool isSingle;
  ///多人?成年人?
  @JsonKey(name: 'is_adult')
  bool isAdult;
  @JsonKey(name: 'is_r15')
  bool isR15;
  @JsonKey(name: 'is_r18')
  bool isR18;
  String publicity;
  @JsonKey(name: 'is_closed')
  bool isClosed;
  //screencast webcam
  String mode;
  String server;
  @JsonKey(name: 'channel_id')
  String channelId;
  //开麦
  @JsonKey(name: 'is_enabled_mic_input')
  bool isEnabledMicInput;
  @JsonKey(name: 'thumbnail_image_url')
  String thumbnailImageUrl;
  @JsonKey(name: 'member_count')
  int memberCount;
  @JsonKey(name: 'total_audience_count')
  int totalAudienceCount;
  @JsonKey(name: 'performer_count')
  int performerCount;
  @JsonKey(name: 'is_muted')
  bool isMuted;

  Live(
    this.id,
    this.createAt,
    this.owner,
    this.performers,
    this.name,
    this.isSingle,
    this.isAdult,
    this.isR15,
    this.isR18,
    this.publicity,
    this.isClosed,
    this.mode,
    this.server,
    this.channelId,
    this.isEnabledMicInput,
    this.thumbnailImageUrl,
    this.memberCount,
    this.totalAudienceCount,
    this.performerCount,
    this.isMuted,
  );

  factory Live.fromJson(Map<String, dynamic> json) => _$LiveFromJson(json);

  Map<String, dynamic> toJson() => _$LiveToJson(this);
}

//嵌套一层的用户
@JsonSerializable(explicitToJson: true)
class NestedUser {
  User user;

  NestedUser(this.user);

  factory NestedUser.fromJson(Map<String, dynamic> json) => _$NestedUserFromJson(json);

  Map<String, dynamic> toJson() => _$NestedUserToJson(this);
}
