import 'package:json_annotation/json_annotation.dart';

import '../model/comment.dart';

part 'comment_add_result.g.dart';

@JsonSerializable(explicitToJson: true)
class CommentAddResult {
  Comment comment;

  CommentAddResult(this.comment);

  factory CommentAddResult.fromJson(Map<String, dynamic> json) => _$CommentAddResultFromJson(json);

  Map<String, dynamic> toJson() => _$CommentAddResultToJson(this);
}
