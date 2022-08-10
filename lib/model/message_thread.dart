import 'package:json_annotation/json_annotation.dart';

part 'message_thread.g.dart';

@JsonSerializable(explicitToJson: true)
class MessageThread {
  @JsonKey(name: 'thread_id')
  String threadId;
  @JsonKey(name: 'modified_at')
  String modifiedAt;
  @JsonKey(name: 'unread_num')
  String unreadNum;
  @JsonKey(name: 'member_num')
  String memberNum;
  @JsonKey(name: 'latest_content')
  String latestContent;
  @JsonKey(name: 'is_pair')
  bool isPair;
  @JsonKey(name: 'thread_name')
  String threadName;
  @JsonKey(name: 'icon_url')
  MessageThreadIconUrl iconUrl;
  bool followed;
  @JsonKey(name: 'is_official')
  bool isOfficial;
  @JsonKey(name: 'is_mendako')
  bool isMendako;
  @JsonKey(name: 'is_active_thread')
  bool isActiveThread;
  @JsonKey(name: 'is_fanbox_subscriber')
  bool isFanboxSubscriber;

  MessageThread(
    this.threadId,
    this.modifiedAt,
    this.unreadNum,
    this.memberNum,
    this.latestContent,
    this.isPair,
    this.threadName,
    this.iconUrl,
    this.followed,
    this.isOfficial,
    this.isMendako,
    this.isActiveThread,
    this.isFanboxSubscriber,
  );

  factory MessageThread.fromJson(Map<String, dynamic> json) => _$MessageThreadFromJson(json);

  Map<String, dynamic> toJson() => _$MessageThreadToJson(this);
}

@JsonSerializable(explicitToJson: true)
class MessageThreadIconUrl {
  @JsonKey(name: '100x100')
  String px100x100;

  MessageThreadIconUrl(this.px100x100);

  factory MessageThreadIconUrl.fromJson(Map<String, dynamic> json) => _$MessageThreadIconUrlFromJson(json);

  Map<String, dynamic> toJson() => _$MessageThreadIconUrlToJson(this);
}
