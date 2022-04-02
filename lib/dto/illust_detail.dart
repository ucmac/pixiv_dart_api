import 'package:json_annotation/json_annotation.dart';

import '../entity/illust.dart';

part 'illust_detail.g.dart';

@JsonSerializable(explicitToJson: true)
class IllustDetail {
  Illust illust;

  IllustDetail(this.illust);

  factory IllustDetail.fromJson(Map<String, dynamic> json) => _$IllustDetailFromJson(json);

  Map<String, dynamic> toJson() => _$IllustDetailToJson(this);
}
