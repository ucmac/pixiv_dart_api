import 'package:json_annotation/json_annotation.dart';

import '../model/comment.dart';
import 'page_list.dart';

part 'comment_page_result.g.dart';

@JsonSerializable(explicitToJson: true)
class CommentPageResult implements IPageList {
  List<Comment> comments;
  @JsonKey(name: 'next_url')
  @override
  String? nextUrl;

  CommentPageResult(this.comments, this.nextUrl);

  factory CommentPageResult.fromJson(Map<String, dynamic> json) => _$CommentPageResultFromJson(json);

  Map<String, dynamic> toJson() => _$CommentPageResultToJson(this);
}
