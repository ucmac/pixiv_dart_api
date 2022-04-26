import 'package:json_annotation/json_annotation.dart';

part 'stamp.g.dart';

@JsonSerializable(explicitToJson: true)
class Stamp {
  @JsonKey(name: 'stamp_id')
  int stampId;
  @JsonKey(name: 'stamp_url')
  String stampUrl;

  Stamp(this.stampId, this.stampUrl);

  factory Stamp.fromJson(Map<String, dynamic> json) => _$StampFromJson(json);

  Map<String, dynamic> toJson() => _$StampToJson(this);
}
