import 'package:json_annotation/json_annotation.dart';

import '../model/message_thread.dart';

part 'message_thread_page_result.g.dart';

@JsonSerializable(explicitToJson: true)
class MessageThreadPageResult {
  bool error;
  String message;
  MessageThreadBody body;

  MessageThreadPageResult(this.error, this.message, this.body);

  factory MessageThreadPageResult.fromJson(Map<String, dynamic> json) => _$MessageThreadPageResultFromJson(json);

  Map<String, dynamic> toJson() => _$MessageThreadPageResultToJson(this);
}

@JsonSerializable(explicitToJson: true)
class MessageThreadBody {
  int total;
  @JsonKey(name: 'message_threads')
  List<MessageThread> messageThreads;
  @JsonKey(name: 'next_url')
  String? nextUrl;

  MessageThreadBody(this.total, this.messageThreads, this.nextUrl);

  factory MessageThreadBody.fromJson(Map<String, dynamic> json) => _$MessageThreadBodyFromJson(json);

  Map<String, dynamic> toJson() => _$MessageThreadBodyToJson(this);
}
