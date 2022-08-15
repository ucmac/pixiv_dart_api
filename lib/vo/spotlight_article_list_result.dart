import 'package:json_annotation/json_annotation.dart';

import '../model/spotlight_article.dart';

part 'spotlight_article_list_result.g.dart';

@JsonSerializable(explicitToJson: true)
class SpotlightArticleListResult {
  @JsonKey(name: 'spotlight_articles')
  List<SpotlightArticle> spotlightArticles;

  SpotlightArticleListResult(this.spotlightArticles);

  factory SpotlightArticleListResult.fromJson(Map<String, dynamic> json) => _$SpotlightArticleListResultFromJson(json);

  Map<String, dynamic> toJson() => _$SpotlightArticleListResultToJson(this);
}
