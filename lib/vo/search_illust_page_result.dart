import 'package:json_annotation/json_annotation.dart';

import '../model/illust.dart';
import 'page_list.dart';

part 'search_illust_page_result.g.dart';

@JsonSerializable(explicitToJson: true)
class SearchIllustPageResult implements IPageList {
  List<Illust> illusts;
  @JsonKey(name: 'next_url')
  @override
  String? nextUrl;
  @JsonKey(name: 'search_span_limit')
  int searchSpanLimit;

  SearchIllustPageResult(this.illusts, this.nextUrl, this.searchSpanLimit);

  factory SearchIllustPageResult.fromJson(Map<String, dynamic> json) => _$SearchIllustPageResultFromJson(json);

  Map<String, dynamic> toJson() => _$SearchIllustPageResultToJson(this);
}
