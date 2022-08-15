// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spotlight_article.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpotlightArticle _$SpotlightArticleFromJson(Map<String, dynamic> json) =>
    SpotlightArticle(
      json['id'] as int,
      json['title'] as String,
      json['pure_title'] as String,
      json['thumbnail'] as String,
      json['article_url'] as String,
      json['publish_date'] as String,
      json['category'] as String,
      json['sybcategory_label'] as String,
    );

Map<String, dynamic> _$SpotlightArticleToJson(SpotlightArticle instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'pure_title': instance.pureTitle,
      'thumbnail': instance.thumbnail,
      'article_url': instance.articleUrl,
      'publish_date': instance.publishDate,
      'category': instance.category,
      'sybcategory_label': instance.subcategoryLabel,
    };
