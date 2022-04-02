import 'package:json_annotation/json_annotation.dart';

import '../entity/novel.dart';

part 'novels.g.dart';

@JsonSerializable(explicitToJson: true)
class Novels {
  List<Novel> novels;
  String? nextUrl;

  Novels(this.novels, this.nextUrl);

  factory Novels.fromJson(Map<String, dynamic> json) => _$NovelsFromJson(json);

  Map<String, dynamic> toJson() => _$NovelsToJson(this);
}
