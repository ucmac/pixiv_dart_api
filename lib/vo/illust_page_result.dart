import 'package:json_annotation/json_annotation.dart';

import '../model/illust.dart';
import 'page_list.dart';

part 'illust_page_result.g.dart';

@JsonSerializable(explicitToJson: true)
class IllustPageResult implements IPageList {
  List<Illust> illusts;
  @JsonKey(name: 'next_url')
  @override
  String? nextUrl;

  IllustPageResult(this.illusts, this.nextUrl);

  factory IllustPageResult.fromJson(Map<String, dynamic> json) => _$IllustPageResultFromJson(json);

  Map<String, dynamic> toJson() => _$IllustPageResultToJson(this);
}
