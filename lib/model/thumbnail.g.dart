// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'thumbnail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Thumbnail _$ThumbnailFromJson(Map<String, dynamic> json) => Thumbnail(
      ThumbnailUrl.fromJson(json['sq800'] as Map<String, dynamic>),
      ThumbnailUrl.fromJson(json['w160'] as Map<String, dynamic>),
      ThumbnailUrl.fromJson(json['w400'] as Map<String, dynamic>),
      ThumbnailUrl.fromJson(json['w1280'] as Map<String, dynamic>),
      ThumbnailUrl.fromJson(json['original'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ThumbnailToJson(Thumbnail instance) => <String, dynamic>{
      'sq800': instance.sq800.toJson(),
      'w160': instance.w160.toJson(),
      'w400': instance.w400.toJson(),
      'w1280': instance.w1280.toJson(),
      'original': instance.original.toJson(),
    };

ThumbnailUrl _$ThumbnailUrlFromJson(Map<String, dynamic> json) => ThumbnailUrl(
      json['url'] as String,
    );

Map<String, dynamic> _$ThumbnailUrlToJson(ThumbnailUrl instance) =>
    <String, dynamic>{
      'url': instance.url,
    };
