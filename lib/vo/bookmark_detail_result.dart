import 'package:json_annotation/json_annotation.dart';

part 'bookmark_detail_result.g.dart';

@JsonSerializable(explicitToJson: true)
class BookmarkDetailResult {
  @JsonKey(name: 'is_bookmarked')
  bool isBookmarked;
  List<String> tags;
  String restrict;

  BookmarkDetailResult(this.isBookmarked, this.tags, this.restrict);

  factory BookmarkDetailResult.fromJson(Map<String, dynamic> json) => _$BookmarkDetailResultFromJson(json);

  Map<String, dynamic> toJson() => _$BookmarkDetailResultToJson(this);
}
