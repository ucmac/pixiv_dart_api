import 'package:json_annotation/json_annotation.dart';

import '../model/tag.dart';

part 'search_autocomplete_result.g.dart';

@JsonSerializable(explicitToJson: true)
class SearchAutocompleteResult {
  List<Tag> tags;

  SearchAutocompleteResult(this.tags);

  factory SearchAutocompleteResult.fromJson(Map<String, dynamic> json) => _$SearchAutocompleteResultFromJson(json);

  Map<String, dynamic> toJson() => _$SearchAutocompleteResultToJson(this);
}
