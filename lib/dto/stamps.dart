import 'package:json_annotation/json_annotation.dart';

import '../entity/stamp.dart';

part 'stamps.g.dart';

@JsonSerializable(explicitToJson: true)
class Stamps {
  List<Stamp> stamps;

  Stamps(this.stamps);

  factory Stamps.fromJson(Map<String, dynamic> json) => _$StampsFromJson(json);

  Map<String, dynamic> toJson() => _$StampsToJson(this);
}
