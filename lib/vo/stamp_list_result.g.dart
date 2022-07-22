// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stamp_list_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StampListResult _$StampListResultFromJson(Map<String, dynamic> json) =>
    StampListResult(
      (json['stamps'] as List<dynamic>)
          .map((e) => Stamp.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$StampListResultToJson(StampListResult instance) =>
    <String, dynamic>{
      'stamps': instance.stamps.map((e) => e.toJson()).toList(),
    };
