import 'package:json_annotation/json_annotation.dart';

import '../model/novel.dart';
import 'page_list.dart';

part 'search_novel_page_result.g.dart';

@JsonSerializable(explicitToJson: true)
class SearchNovelPageResult implements IPageList {
  List<Novel> novels;
  @JsonKey(name: 'next_url')
  @override
  String? nextUrl;
  @JsonKey(name: 'search_span_limit')
  int searchSpanLimit;

  SearchNovelPageResult(this.novels, this.nextUrl, this.searchSpanLimit);

  factory SearchNovelPageResult.fromJson(Map<String, dynamic> json) => _$SearchNovelPageResultFromJson(json);

  Map<String, dynamic> toJson() => _$SearchNovelPageResultToJson(this);
}
