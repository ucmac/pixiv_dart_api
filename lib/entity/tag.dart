import 'package:json_annotation/json_annotation.dart';

part 'tag.g.dart';

@JsonSerializable(explicitToJson: true)
class Tag {
  String name;
  @JsonKey(name: 'translated_name')
  String? translatedName;

  Tag(this.name, this.translatedName);

  factory Tag.fromJson(Map<String, dynamic> json) => _$TagFromJson(json);

  Map<String, dynamic> toJson() => _$TagToJson(this);
}
