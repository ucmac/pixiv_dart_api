import 'package:json_annotation/json_annotation.dart';

import '../entity/tag.dart';

part 'search_autocomplete.g.dart';

@JsonSerializable(explicitToJson: true)
class SearchAutocomplete {
  List<Tag> tags;

  SearchAutocomplete(this.tags);

  factory SearchAutocomplete.fromJson(Map<String, dynamic> json) => _$SearchAutocompleteFromJson(json);

  Map<String, dynamic> toJson() => _$SearchAutocompleteToJson(this);
}
