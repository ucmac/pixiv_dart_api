import 'package:json_annotation/json_annotation.dart';

import '../entity/bookmark_tag.dart';

part 'bookmark_tags.g.dart';

@JsonSerializable(explicitToJson: true)
class BookmarkTags {
  @JsonKey(name: 'bookmark_tags')
  List<BookmarkTag> bookmarkTags;
  @JsonKey(name: 'next_url')
  String? nextUrl;

  BookmarkTags(this.bookmarkTags, this.nextUrl);

  factory BookmarkTags.fromJson(Map<String, dynamic> json) => _$BookmarkTagsFromJson(json);

  Map<String, dynamic> toJson() => _$BookmarkTagsToJson(this);
}
