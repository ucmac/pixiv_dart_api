import 'package:json_annotation/json_annotation.dart';

part 'bookmark_tag.g.dart';

@JsonSerializable(explicitToJson: true)
class BookmarkTag {
  String name;
  int count;

  BookmarkTag(this.name, this.count);

  factory BookmarkTag.fromJson(Map<String, dynamic> json) => _$BookmarkTagFromJson(json);

  Map<String, dynamic> toJson() => _$BookmarkTagToJson(this);
}
