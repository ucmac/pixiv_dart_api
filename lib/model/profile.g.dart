// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileAddress _$ProfileAddressFromJson(Map<String, dynamic> json) =>
    ProfileAddress(
      json['id'] as int,
      json['name'] as String,
      json['is_global'] as bool,
    );

Map<String, dynamic> _$ProfileAddressToJson(ProfileAddress instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'is_global': instance.isGlobal,
    };

ProfileCountry _$ProfileCountryFromJson(Map<String, dynamic> json) =>
    ProfileCountry(
      json['code'] as String,
      json['name'] as String,
    );

Map<String, dynamic> _$ProfileCountryToJson(ProfileCountry instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
    };

ProfileJob _$ProfileJobFromJson(Map<String, dynamic> json) => ProfileJob(
      json['id'] as int,
      json['name'] as String,
    );

Map<String, dynamic> _$ProfileJobToJson(ProfileJob instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

ProfileImageUrls _$ProfileImageUrlsFromJson(Map<String, dynamic> json) =>
    ProfileImageUrls(
      json['medium'] as String,
    );

Map<String, dynamic> _$ProfileImageUrlsToJson(ProfileImageUrls instance) =>
    <String, dynamic>{
      'medium': instance.medium,
    };
