import 'package:json_annotation/json_annotation.dart';

part 'message_thread_content.g.dart';

@JsonSerializable(explicitToJson: true)
class MessageThreadContent {
  @JsonKey(name: 'content_id')
  String contentId;
  @JsonKey(name: 'thread_id')
  String threadId;
  MessageContentUser user;
  @JsonKey(name: 'created_at')
  String createAt;
  MessageContent content;
  ///是自己
  @JsonKey(name: 'is_complete_user')
  bool isCompleteUser;

  MessageThreadContent(this.contentId, this.threadId, this.user, this.createAt, this.content, this.isCompleteUser);

  factory MessageThreadContent.fromJson(Map<String, dynamic> json) => _$MessageThreadContentFromJson(json);

  Map<String, dynamic> toJson() => _$MessageThreadContentToJson(this);
}

@JsonSerializable(explicitToJson: true)
class MessageContentUser {
  @JsonKey(name: 'user_id')
  String userId;
  @JsonKey(name: 'user_name')
  String userName;
  @JsonKey(name: 'icon_url')
  MessageContentUserIconUrl iconUrl;

  MessageContentUser(this.userId, this.userName, this.iconUrl);

  factory MessageContentUser.fromJson(Map<String, dynamic> json) => _$MessageContentUserFromJson(json);

  Map<String, dynamic> toJson() => _$MessageContentUserToJson(this);
}

@JsonSerializable(explicitToJson: true)
class MessageContentUserIconUrl {
  @JsonKey(name: 'main_s')
  String mainS;

  MessageContentUserIconUrl(this.mainS);

  factory MessageContentUserIconUrl.fromJson(Map<String, dynamic> json) => _$MessageContentUserIconUrlFromJson(json);

  Map<String, dynamic> toJson() => _$MessageContentUserIconUrlToJson(this);
}

@JsonSerializable(explicitToJson: true)
class MessageContent {
  /// text image两种
  String type;

  /// type为text时才有
  String? text;

  /// type为text时才有
  @JsonKey(name: 'is_starred')

  /// type为text时才有
  bool? isStarred;

  /// type为image时才有
  @JsonKey(name: 'image_urls')
  MessageContentImageUrls? imageUrls;

  /// type为image时才有
  String? width;

  /// type为image时才有
  String? height;

  MessageContent(this.type, this.text, this.isStarred, this.imageUrls, this.width, this.height);

  factory MessageContent.fromJson(Map<String, dynamic> json) => _$MessageContentFromJson(json);

  Map<String, dynamic> toJson() => _$MessageContentToJson(this);
}

@JsonSerializable(explicitToJson: true)
class MessageContentImageUrls {
  @JsonKey(name: '100x100')
  String px100x100;
  @JsonKey(name: '200x200')
  String px200x200;
  @JsonKey(name: '400x400')
  String px400x400;
  @JsonKey(name: '600x600')
  String px600x600;
  String big;

  MessageContentImageUrls(this.px100x100, this.px200x200, this.px400x400, this.px600x600, this.big);

  factory MessageContentImageUrls.fromJson(Map<String, dynamic> json) => _$MessageContentImageUrlsFromJson(json);

  Map<String, dynamic> toJson() => _$MessageContentImageUrlsToJson(this);
}
