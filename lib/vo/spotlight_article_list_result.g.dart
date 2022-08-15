// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spotlight_article_list_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpotlightArticleListResult _$SpotlightArticleListResultFromJson(
        Map<String, dynamic> json) =>
    SpotlightArticleListResult(
      (json['spotlight_articles'] as List<dynamic>)
          .map((e) => SpotlightArticle.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SpotlightArticleListResultToJson(
        SpotlightArticleListResult instance) =>
    <String, dynamic>{
      'spotlight_articles':
          instance.spotlightArticles.map((e) => e.toJson()).toList(),
    };
