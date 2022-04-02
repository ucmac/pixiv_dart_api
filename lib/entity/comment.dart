import 'package:json_annotation/json_annotation.dart';

import 'stamp.dart';
import 'user.dart';

part 'comment.g.dart';

@JsonSerializable(explicitToJson: true)
class Comment {
  int id;

  ///内容
  String comment;
  String date;
  User user;
  @JsonKey(name: 'has_replies')
  bool hasReplies;
  Stamp? stamp;

  Comment(this.id, this.comment, this.date, this.user, this.hasReplies, this.stamp);

  factory Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);

  Map<String, dynamic> toJson() => _$CommentToJson(this);
}
