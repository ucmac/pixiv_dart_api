import 'package:json_annotation/json_annotation.dart';

import '../entity/novel.dart';

part 'search_novel.g.dart';

@JsonSerializable(explicitToJson: true)
class SearchNovel {
  List<Novel> novels;
  @JsonKey(name: 'next_url')
  String? nextUrl;
  @JsonKey(name: 'search_span_limit')
  int searchSpanLimit;

  SearchNovel(this.novels, this.nextUrl, this.searchSpanLimit);

  factory SearchNovel.fromJson(Map<String, dynamic> json) => _$SearchNovelFromJson(json);

  Map<String, dynamic> toJson() => _$SearchNovelToJson(this);
}
