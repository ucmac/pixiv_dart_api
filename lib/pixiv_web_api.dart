import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:pixiv_dart_api/interceptors/retry_interceptor.dart';
import 'package:pixiv_dart_api/vo/message_thread_content_page_result.dart';
import 'package:pixiv_dart_api/vo/message_thread_page_result.dart';

class PixivWebApi {
  static const _cookie = '';
  static const _userAgent = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/103.0.0.0 Safari/537.36';

  Dio get _httpClient {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://210.140.92.183',
        responseType: ResponseType.plain,
        headers: {
          'Referer': 'https://www.pixiv.net/',
          'Host': "www.pixiv.net",
          'Cookie': _cookie,
          'User-Agent': _userAgent,
        },
        connectTimeout: 5 * 1000,
        receiveTimeout: 5 * 1000,
        sendTimeout: 5 * 1000,
      ),
    );
    dio.interceptors.add(RetryInterceptor(dio, hasMore: false));
    return dio;
  }

  //PC端
  Future<MessageThreadPageResult> getLatestMessagePage({
    required int offset,
    required int limit,
  }) async {
    return _httpClient.get<String>(
      '/rpc/index.php',
      queryParameters: {
        'mode': 'latest_message_threads2',
        'offset': offset,
        'num': limit,
      },
    ).then((response) => MessageThreadPageResult.fromJson(jsonDecode(response.data!)));
  }

  Future<MessageThreadContentPageResult> getMessageContentPage({
    required int threadId,
    required int limit,
  }) {
    return _httpClient.get<String>(
      '/rpc/index.php',
      queryParameters: {
        'mode': 'message_thread_contents',
        'thread_id': threadId,
        'num': limit,
      },
    ).then((response) => MessageThreadContentPageResult.fromJson(jsonDecode(response.data!)));
  }

  Future<void> postClearUnreadCount() {
    //https://www.pixiv.net/touch/ajax_api/messages_api.php
    return _httpClient.post<String>(
      '/touch/ajax_api/messages_api.php',
      queryParameters: {
        'mode': 'clear_unread_count',
        'tt': '',
      },
    );
  }

  ///首次发送消息(只能发送文字)
  ///
  /// [receiveId] 用户id
  Future<String> postMessageContentFirst({
    required int receiveId,
    required String text,
  }) {
    //https://www.pixiv.net/messages.php?receiver_id=$receiveId
    //tt = window.pixiv.context.token
    return _httpClient
        .post<String>(
          '/rpc/index.php',
          data: FormData.fromMap({
            'mode': 'message_thread_pair_content_text_first',
            'receive_id': receiveId,
            'text': text,
            'tt': '',
          }),
        )
        .then((response) => response.data!);
  }

  ///发送消息可以发送图片和文字
  Future<String> postMessageContent({
    required int threadId,
    String? text,
    Uint8List? imageBytes,
  }) {
    //https://www.pixiv.net/messages.php?thread_id=$threadId
    //recaptcha_enterprise_score_token = window.pixiv.context.recaptchaEnterpriseScoreSiteKey
    //tt = window.pixiv.context.token
    final formData = FormData.fromMap({
      'mode': 'message_thread_content_image_text',
      'thread_id': threadId,
      'text': text,
      'recaptcha_enterprise_score_token': '',
      'tt': '',
    }..removeWhere((key, value) => null == value));
    if (null != imageBytes) {
      formData.files.add(MapEntry('upfile', MultipartFile.fromBytes(imageBytes)));
    }
    return _httpClient
        .post<String>(
          '/rpc/index.php',
          data: formData,
        )
        .then((response) => response.data!);
  }

  Future<Map<String, dynamic>> getPixivContext() {
    return _httpClient.get<String>('/messages.php').then((response) {
      String htmlString = response.data!;
      final tokenStartIndex = htmlString.indexOf('"', htmlString.indexOf('pixiv.context.token = ')) + 1;
      final tokenEndIndex = htmlString.indexOf(
        '"',
        htmlString.lastIndexOf('pixiv.context.token = "') + 'pixiv.context.token = "'.length,
      );

      final siteKeyStartIndex = htmlString.indexOf('"', htmlString.indexOf('pixiv.context.recaptchaEnterpriseScoreSiteKey = ')) + 1;
      final siteKeyEndIndex = htmlString.indexOf(
        '"',
        htmlString.indexOf('pixiv.context.recaptchaEnterpriseScoreSiteKey = "') + 'pixiv.context.recaptchaEnterpriseScoreSiteKey = "'.length,
      );

      final token = htmlString.substring(tokenStartIndex, tokenEndIndex);
      final siteKey = htmlString.substring(siteKeyStartIndex, siteKeyEndIndex);
      return {
        'token': token,
        'recaptchaEnterpriseScoreSiteKey': siteKey,
      };
    });
  }
}
