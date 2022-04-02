import 'package:json_annotation/json_annotation.dart';

import '../entity/user_preview.dart';

part 'users.g.dart';

@JsonSerializable(explicitToJson: true)
class Users {
  @JsonKey(name: 'user_previews')
  List<UserPreview> userPreviews;
  @JsonKey(name: 'next_url')
  String? nextUrl;

  Users(this.userPreviews, this.nextUrl);
  factory Users.fromJson(Map<String, dynamic> json) => _$UsersFromJson(json);

  Map<String, dynamic> toJson() => _$UsersToJson(this);
}
