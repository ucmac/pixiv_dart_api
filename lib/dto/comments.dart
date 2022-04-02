import 'package:json_annotation/json_annotation.dart';

import '../entity/comment.dart';

part 'comments.g.dart';

@JsonSerializable(explicitToJson: true)
class Comments {
  List<Comment> comments;
  @JsonKey(name: 'next_url')
  String? nextUrl;

  Comments(this.comments, this.nextUrl);

  factory Comments.fromJson(Map<String, dynamic> json) => _$CommentsFromJson(json);

  Map<String, dynamic> toJson() => _$CommentsToJson(this);
}
