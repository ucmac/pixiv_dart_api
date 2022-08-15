import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:pixiv_dart_api/interceptors/retry_interceptor.dart';
import 'package:pixiv_dart_api/vo/message_thread_content_page_result.dart';
import 'package:pixiv_dart_api/vo/message_thread_page_result.dart';

class PixivWebApi {
  late final String Function() cookieGetter;
  late final String Function() targetIPGetter;
  late final void Function(String userAccount) cookieUpdater;

  ///兼容GetX的GetxService
  PixivWebApi init({
    required String Function() cookieGetter,
    required String Function() targetIPGetter,
    required void Function(String cookie) cookieUpdater,
  }) {
    this.cookieGetter = cookieGetter;
    this.targetIPGetter = targetIPGetter;
    this.cookieUpdater = cookieUpdater;
    return this;
  }

  // static const _cookie = 'first_visit_datetime_pc=2022-06-08+23:35:54; p_ab_id=2; p_ab_id_2=6; p_ab_d_id=1726629804; yuid_b=JnEhB1I; privacy_policy_notification=0; a_type=0; login_ever=yes; _im_vid=01G6X9J4CZFNNVYP4ZE6THK8EJ; _fbp=fb.1.1656693161903.654825864; first_visit_datetime=2022-07-07+19:19:22; webp_available=1; __utmv=235335808.|2=login ever=yes=1^3=plan=normal=1^5=gender=female=1^6=user_id=72269198=1^9=p_ab_id=2=1^10=p_ab_id_2=6=1^11=lang=zh=1^20=webp_available=yes=1; _pbjs_userid_consent_data=3524755945110770; _im_vid=01G6X9J4CZFNNVYP4ZE6THK8EJ; __utmz=235335808.1657212597.6.4.utmcsr=accounts.pixiv.net|utmccn=(referral)|utmcmd=referral|utmcct=/; _gcl_au=1.1.983486920.1657212684; device_token=c3f40fbfdb243f5095cac40d606699e8; adr_id=sms5bmwTzR71kRQCw1fcbKCbjCxmmMhVpOPuOZph0tEbRdqr; limited_ads={"t_footer_top":"","t_header":"","t_footer":""}; cto_bidid=LbEP619meEVPc2t1dDFuM0NMY2hBMmxrJTJCSzAxVGxETTh2dHc0MXF5c3dPVU15JTJCSURteSUyQiUyQnVsTkt1TW5rNyUyRlB1Ym5YZ0NUSmJhWCUyRk5TeFp5dXZncnJlV1RNc21UQU01NkNZRSUyQmlvcyUyRnVTc1V0Q245ZWp4WGRlVU8xYXZ0ZmFnczVlQ1diektVTUFBdCUyRkdUQjE3SWNyc293cGclM0QlM0Q; __gpi=UID=000006da75455318:T=1657198943:RT=1658647089:S=ALNI_Majjui7AgUMTrrp7fc0sI6C2d0UWA; __gads=ID=862e661617b889a1:T=1657198943:RT=1658647089:S=ALNI_MYKWbfvw51fzqEEAV8JvnQIN17V-w; _ga_3WKBFJLFCP=GS1.1.1658653191.5.0.1658653191.0; __utma=235335808.2037376058.1656693161.1658647076.1658751703.12; cto_bundle=XLkp9196RjNXeEg1ZWI2Zmp4bFpnQ1ZQWXNuMjV6S29BUUhqN0gxWkZTUUd6JTJCdFFsJTJCRmpzb1NVZkVmVGNZeFB1ZzYzTTlVUWY5aXVkamtHdnRlNGlxOEx3ZGpTMUFSOE1sVmE0WiUyRk5CN2VFNEtXZ0dGJTJCamlnTnBMVFVyRVN6Qk4lMkZqS3UwUzVESFVxbEFxV2lzTlZyWXZTbkpRJTNEJTNE; _ga_75BBYNYN9J=GS1.1.1658751703.14.1.1658751791.0; _ga=GA1.2.1212427672.1656693161; QSI_S_ZN_5hF4My7Ad6VNNAi=v:0:0; p_b_type=1; PHPSESSID=72269198_RIVzePS3y1zyfo35LBKmVrsjaa6mLq6a; privacy_policy_agreement=5; c_type=18; b_type=2; tag_view_ranking=0xsDLqCEW6~kGYw4gQ11Z~GNcgbuT3T-~vgSIjfFuho~eVxus64GZU~HY55MqmzzQ~RDSCVEnfFs~CGh6Jq_bAS~RTJMXD26Ak~KOnmT1ndWG~Lt-oEicbBr~BtXd1-LPRH~yxXUNz8bXw~52EMNWn1Tz~txZ9z5ByU7~cNK5pNOIbG~FrtfL9yzt7~-Lny-nXdRn~5oPIfUbtd6~Ltq1hgLZe3~LJo91uBPz4~ZuhRfAQM_q~rfaOhju5br~34_yr-LJv_~HBlflqJjBZ~VTeFUlRxgl~xha5FQn_XC~lH5YZxnbfC~5Rf_nE4tAW~kqu7T68WD3~7WfWkHyQ76~TcgCqYbydo~4QveACRzn3~_EOd7bsGyl~ziiAzr_h04~r01unnQL0a~HzBN8CVKd3~nlMUFfijHT~PNvsDKwKjA~Ekc63fSc_I~gpglyfLkWs~Cj_Gcw9KR1~Vb5-a5NY4a~cRPCkvtePD~I6C_rdN_Hi~RqZAf8VpdW~3XqJ3JywHu~aIgOcTaSZx~w4ZHyZTf3g~m8jdSenntp~vPt77gk5kg~Ib0YGS-7FI~u8McsBs7WV~QaiOjmwQnI~i7kFSU2LBr~RlUj1xlVPW~5f1R8PG9ra~qcYo_5oqVP~NT6HjMvlFJ~XgZwHIIL4V~aPKSYHMJmS~dJgU3VsQmO~q303ip6Ui5~RybylJRnhJ~ykNnpw2uh5~hAaisbVESe~VN7cgWyMmg~oJAJo4VO5E~mqf4KYn6Dx~b1s-xqez0Y~Ce_EPCkBjl~CuBRVd1jy-~aKhT3n4RHZ~GFExx0uFgX~7B9spiRrJg~vJfnTwJTHA~qLCasr8w0T~i0fnzvBFPY~-NJZeKTYP8~a3zvshTj4U~jEoxuA2PIS~yPNaP3JSNF~vSWEvTeZc6~msXRh9Sxoe~FvNhbtMubj~Feb1ZeDNwb~qkC-JF_MXY~yms16YMDp0~MM6RXH_rlN~3gc3uGrU1V~fJa_h7T0vP~SIBtn3ZiUT~EQ7Otj1ezd~p27QC63XHD~zsm1ECW5Wb~DXPphy6Z-6~gstUS2iTzU~Bd2L9ZBE8q~QqlTJrLZO5~jVtkOHXPKr; __cf_bm=Ywc7RyZNHbzIhsTbG5.wgNUWWLb0zUJsZqLaCq3xPy4-1660327217-0-AYyqNlvDw/8jKFqDS0rD1iEddztYGwzcFV2UNF+5hpKMUNWRT5QapmO3q+79gRyk7RnWVL8rF8xKKFs+hpga8BPfE1sWbmbPOljWA2ASNz1rNBH3DUmUbyt+bQp6GEvTkP1X1bwuPzvncyz1o5aqLBUVEsx85+KC+7WSloPozMqdGEhYpmSjxcALwIorVxvn9A==';
  static const _userAgent = 'Mozilla/5.0 (Linux; Android 11; Pixel 5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.91 Mobile Safari/537.36';

  Dio get _httpClient {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://${targetIPGetter.call()}',
        responseType: ResponseType.plain,
        headers: {
          'Referer': 'https://www.pixiv.net/',
          'Host': "www.pixiv.net",
          'Cookie': cookieGetter.call(),
          'User-Agent': _userAgent,
        },
        connectTimeout: 5 * 1000,
        receiveTimeout: 5 * 1000,
        sendTimeout: 5 * 1000,
      ),
    );
    dio.interceptors.add(RetryInterceptor(dio, hasMore: false));
    // dio.interceptors.add(
    //   InterceptorsWrapper(
    //     onResponse: (Response e, ResponseInterceptorHandler handler) {
    //       print('Set-Cookie:${e.headers['Set-Cookie']}');
    //     },
    //   ),
    // );
    return dio;
  }

  Map<String, String> _cookieToMap(String cookie) {
    final list = cookie.split('; ');
    return <String, String>{}
      ..addEntries(
        list.map(
              (item) {
            final keyValue = item.split('=');
            return MapEntry(keyValue.first, keyValue.last);
          },
        ),
      );
  }

  Future<T> getNextPage<T>(String url, {
    required CancelToken cancelToken,
  }) {
    return _httpClient.get<String>(url.replaceFirst("www.pixiv.net", '210.140.92.183'), cancelToken: cancelToken).then((response) {
      final responseData = response.data!;
      if (T == MessageThreadPageResult) {
        return MessageThreadPageResult.fromJson(jsonDecode(responseData)) as T;
      } else if (T == MessageThreadContentPageResult) {
        return MessageThreadContentPageResult.fromJson(jsonDecode(responseData)) as T;
      }
      throw Exception('类型错误');
    });
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
    required CancelToken cancelToken,
  }) {
    return _httpClient
        .get<String>(
      '/rpc/index.php',
      queryParameters: {
        'mode': 'message_thread_contents',
        'thread_id': threadId,
        'num': limit,
      },
      cancelToken: cancelToken,
    )
        .then((response) => MessageThreadContentPageResult.fromJson(jsonDecode(response.data!)));
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
    }
      ..removeWhere((key, value) => null == value));
    if (null != imageBytes) {
      formData.files.add(MapEntry('upfile', MultipartFile.fromBytes(imageBytes)));
    }
    return _httpClient
        .post<String>(
      '/rpc/index.php',
      data: formData,
    )
        .then((response) => response.data!)
        .catchError(
          (e) {
        print(e);
      },
    );
  }

  ///设置年龄限制作品是否显示
  ///
  /// [restrict] 0=safe 1=r18 2=r18g
  Future<String> postSetUserRestrict({required int restrict, required String postKey}) {
    return _httpClient
        .post(
        '/touch/ajax_api/ajax_api.php',
        data: FormData.fromMap(
          {
            'mode': 'set_user_x_restrict',
            'user_x_restrict': restrict,
          },
        ),
        options: Options(
            headers: {
              'x-csrf-token': postKey,
            }
        )
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

  Future<String> getPostKey() {
    return _httpClient.get<String>('/settings.php').then((response) {
      String htmlString = response.data!;
      //"pixiv.context.postKey":"c5aecd8c0669cdb1f762735c1a3fb101"

      //提取postKey的value
      final startIndex = htmlString.indexOf('"', htmlString.indexOf('"pixiv.context.postKey":') + '"pixiv.context.postKey":'.length) + 1;

      final endIndex = htmlString.indexOf('"', htmlString.indexOf('"pixiv.context.postKey":') + '"pixiv.context.postKey":"'.length);

      return htmlString.substring(startIndex, endIndex);
    }).catchError((e) {
      print(e);
    });
  }
}
