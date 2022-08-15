import 'package:json_annotation/json_annotation.dart';

part 'spotlight_article.g.dart';

@JsonSerializable(explicitToJson: true)
class SpotlightArticle {
  int id;
  String title;
  @JsonKey(name: 'pure_title')
  String pureTitle;
  String thumbnail;
  @JsonKey(name: 'article_url')
  String articleUrl;
  @JsonKey(name: 'publish_date')
  String publishDate;
  String category;
  @JsonKey(name: 'sybcategory_label')
  String subcategoryLabel;

  SpotlightArticle(this.id, this.title, this.pureTitle, this.thumbnail, this.articleUrl, this.publishDate, this.category, this.subcategoryLabel);

  factory SpotlightArticle.fromJson(Map<String, dynamic> json) => _$SpotlightArticleFromJson(json);

  Map<String, dynamic> toJson() => _$SpotlightArticleToJson(this);
}
