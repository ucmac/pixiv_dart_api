import 'package:json_annotation/json_annotation.dart';
import 'package:pixiv_dart_api/model/live.dart';
import 'package:pixiv_dart_api/vo/page_list.dart';

part 'live_page_result.g.dart';

@JsonSerializable(explicitToJson: true)
class LivePageResult extends IPageList {
  List<Live> lives;
  @JsonKey(name: 'next_url')
  @override
  String? nextUrl;

  LivePageResult(this.lives, this.nextUrl);

  factory LivePageResult.fromJson(Map<String, dynamic> json) => _$LivePageResultFromJson(json);

  Map<String, dynamic> toJson() => _$LivePageResultToJson(this);
}
