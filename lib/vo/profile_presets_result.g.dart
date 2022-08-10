// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_presets_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfilePresetsResult _$ProfilePresetsResultFromJson(
        Map<String, dynamic> json) =>
    ProfilePresetsResult(
      ProfilePresets.fromJson(json['profile_presets'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProfilePresetsResultToJson(
        ProfilePresetsResult instance) =>
    <String, dynamic>{
      'profile_presets': instance.profilePresets.toJson(),
    };

ProfilePresets _$ProfilePresetsFromJson(Map<String, dynamic> json) =>
    ProfilePresets(
      (json['addresses'] as List<dynamic>)
          .map((e) => ProfileAddress.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['countries'] as List<dynamic>)
          .map((e) => ProfileCountry.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['jobs'] as List<dynamic>)
          .map((e) => ProfileJob.fromJson(e as Map<String, dynamic>))
          .toList(),
      ProfileImageUrls.fromJson(
          json['default_profile_image_urls'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProfilePresetsToJson(ProfilePresets instance) =>
    <String, dynamic>{
      'addresses': instance.addresses.map((e) => e.toJson()).toList(),
      'countries': instance.countries.map((e) => e.toJson()).toList(),
      'jobs': instance.jobs.map((e) => e.toJson()).toList(),
      'default_profile_image_urls': instance.defaultProfileImageUrls.toJson(),
    };
