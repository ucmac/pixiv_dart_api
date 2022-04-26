import 'package:json_annotation/json_annotation.dart';

part 'novel_js_data.g.dart';

@JsonSerializable(explicitToJson: true)
class NovelJSData {
  String id; //int
  String? seriesId; //int
  String userId; //int
  String coverUrl;

  String text;
  SeriesNavigation? seriesNavigation;

  NovelJSData(
    this.id,
    this.seriesId,
    this.userId,
    this.coverUrl,
    this.seriesNavigation,
    this.text,
  );

  factory NovelJSData.fromJson(Map<String, dynamic> json) => _$NovelJSDataFromJson(json);

  Map<String, dynamic> toJson() => _$NovelJSDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SeriesNavigation {
  TurnPageNovel? nextNovel;
  TurnPageNovel? prevNovel;

  SeriesNavigation(this.nextNovel, this.prevNovel);

  factory SeriesNavigation.fromJson(Map<String, dynamic> json) => _$SeriesNavigationFromJson(json);

  Map<String, dynamic> toJson() => _$SeriesNavigationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class TurnPageNovel {
  int id;
  bool viewable;

  //页码
  String contentOrder; // int
  String title;
  String coverUrl;

  //viewableMessage
  TurnPageNovel(this.id, this.viewable, this.contentOrder, this.title, this.coverUrl);

  factory TurnPageNovel.fromJson(Map<String, dynamic> json) => _$TurnPageNovelFromJson(json);

  Map<String, dynamic> toJson() => _$TurnPageNovelToJson(this);
}
