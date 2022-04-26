import 'package:json_annotation/json_annotation.dart';

import '../model/novel.dart';
import 'page_list.dart';

part 'novel_page_result.g.dart';

@JsonSerializable(explicitToJson: true)
class NovelPageResult implements IPageList {
  List<Novel> novels;
  @override
  String? nextUrl;

  NovelPageResult(this.novels, this.nextUrl);

  factory NovelPageResult.fromJson(Map<String, dynamic> json) => _$NovelPageResultFromJson(json);

  Map<String, dynamic> toJson() => _$NovelPageResultToJson(this);
}
