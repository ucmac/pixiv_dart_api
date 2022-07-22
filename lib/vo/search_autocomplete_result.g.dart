// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_autocomplete_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchAutocompleteResult _$SearchAutocompleteResultFromJson(
        Map<String, dynamic> json) =>
    SearchAutocompleteResult(
      (json['tags'] as List<dynamic>)
          .map((e) => Tag.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SearchAutocompleteResultToJson(
        SearchAutocompleteResult instance) =>
    <String, dynamic>{
      'tags': instance.tags.map((e) => e.toJson()).toList(),
    };
