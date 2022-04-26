import 'package:json_annotation/json_annotation.dart';

import '../model/user_preview.dart';
import 'page_list.dart';

part 'user_page_result.g.dart';

@JsonSerializable(explicitToJson: true)
class UserPageResult implements IPageList {
  @JsonKey(name: 'user_previews')
  List<UserPreview> userPreviews;

  @JsonKey(name: 'next_url')
  @override
  String? nextUrl;

  UserPageResult(this.userPreviews, this.nextUrl);

  factory UserPageResult.fromJson(Map<String, dynamic> json) => _$UserPageResultFromJson(json);

  Map<String, dynamic> toJson() => _$UserPageResultToJson(this);
}
