import 'package:json_annotation/json_annotation.dart';

import 'illust.dart';
import 'user.dart';

part 'user_preview.g.dart';

@JsonSerializable(explicitToJson: true)
class UserPreview {
  User user;
  List<Illust> illusts;

  //novels : List<Novel> 小说

  @JsonKey(name: 'is_muted')
  bool isMuted;

  UserPreview(this.user, this.illusts, this.isMuted);

  factory UserPreview.fromJson(Map<String, dynamic> json) => _$UserPreviewFromJson(json);

  Map<String, dynamic> toJson() => _$UserPreviewToJson(this);
}
