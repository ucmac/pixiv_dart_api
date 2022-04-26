import 'package:json_annotation/json_annotation.dart';

import '../model/stamp.dart';

part 'stamp_list_result.g.dart';

@JsonSerializable(explicitToJson: true)
class StampListResult {
  List<Stamp> stamps;

  StampListResult(this.stamps);

  factory StampListResult.fromJson(Map<String, dynamic> json) => _$StampListResultFromJson(json);

  Map<String, dynamic> toJson() => _$StampListResultToJson(this);
}
