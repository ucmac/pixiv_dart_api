import 'package:json_annotation/json_annotation.dart';
import 'package:pixiv_dart_api/model/message_thread_content.dart';

import '../model/message_thread.dart';

part 'message_thread_content_page_result.g.dart';

@JsonSerializable(explicitToJson: true)
class MessageThreadContentPageResult {
  bool error;
  String message;
  MessageThreadContentBody body;

  MessageThreadContentPageResult(this.error, this.message, this.body);

  factory MessageThreadContentPageResult.fromJson(Map<String, dynamic> json) => _$MessageThreadContentPageResultFromJson(json);

  Map<String, dynamic> toJson() => _$MessageThreadContentPageResultToJson(this);
}

@JsonSerializable(explicitToJson: true)
class MessageThreadContentBody {
  String total;
  @JsonKey(name: 'message_thread_contents')
  List<MessageThreadContent> messageThreadContents;
  @JsonKey(name: 'next_url')
  String? nextUrl;

  MessageThreadContentBody(this.total, this.messageThreadContents, this.nextUrl);

  factory MessageThreadContentBody.fromJson(Map<String, dynamic> json) => _$MessageThreadContentBodyFromJson(json);

  Map<String, dynamic> toJson() => _$MessageThreadContentBodyToJson(this);
}
