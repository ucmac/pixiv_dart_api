import 'package:json_annotation/json_annotation.dart';

import '../model/bookmark_tag.dart';
import 'page_list.dart';

part 'bookmark_tag_page_result.g.dart';

@JsonSerializable(explicitToJson: true)
class BookmarkTagPageResult implements IPageList {
  @JsonKey(name: 'bookmark_tags')
  List<BookmarkTag> bookmarkTags;
  @JsonKey(name: 'next_url')
  @override
  String? nextUrl;

  BookmarkTagPageResult(this.bookmarkTags, this.nextUrl);

  factory BookmarkTagPageResult.fromJson(Map<String, dynamic> json) => _$BookmarkTagPageResultFromJson(json);

  Map<String, dynamic> toJson() => _$BookmarkTagPageResultToJson(this);
}
