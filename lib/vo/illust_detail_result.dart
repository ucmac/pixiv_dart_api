import 'package:json_annotation/json_annotation.dart';

import '../model/illust.dart';

part 'illust_detail_result.g.dart';

@JsonSerializable(explicitToJson: true)
class IllustDetailResult {
  Illust illust;

  IllustDetailResult(this.illust);

  factory IllustDetailResult.fromJson(Map<String, dynamic> json) => _$IllustDetailResultFromJson(json);

  Map<String, dynamic> toJson() => _$IllustDetailResultToJson(this);
}
