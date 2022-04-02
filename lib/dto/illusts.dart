import 'package:json_annotation/json_annotation.dart';

import '../entity/illust.dart';

part 'illusts.g.dart';

@JsonSerializable(explicitToJson: true)
class Illusts {
  List<Illust> illusts;
  @JsonKey(name: 'next_url')
  String? nextUrl;

  Illusts(this.illusts, this.nextUrl);

  factory Illusts.fromJson(Map<String, dynamic> json) => _$IllustsFromJson(json);

  Map<String, dynamic> toJson() => _$IllustsToJson(this);
}
