import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';

import 'interceptors/retry_interceptor.dart';
import 'vo/user_account_result.dart';

class PixivAuth {
  late final String Function() targetIPGetter;
  late final String Function() languageGetter;
  late final String deviceName;

  ///兼容GetX的GetxService
  PixivAuth init({
    required String Function() targetIPGetter,
    required String Function() languageGetter,
    required String deviceName,
  }) {
    this.targetIPGetter = targetIPGetter;
    this.languageGetter = languageGetter;
    this.deviceName = deviceName;
    codeVerifier = List.generate(128, (i) => _randomKeySet[Random.secure().nextInt(_randomKeySet.length)]).join();
    codeChallenge = base64Url.encode(sha256.convert(ascii.encode(codeVerifier)).bytes).replaceAll('=', '');
    return this;
  }

  late final String codeVerifier;
  late final String codeChallenge;

  Dio get _httpClient {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://${targetIPGetter.call()}',
        responseType: ResponseType.plain,
        contentType: Headers.formUrlEncodedContentType,
        headers: {
          'User-Agent': 'PixivAndroidApp/6.21.1 (Android 11.0; $deviceName)',
          'App-OS': 'android',
          'App-OS-Version': '11.0',
          'App-Version': '6.21.1',
          'Accept-Language': languageGetter.call(),
          'Host': "oauth.secure.pixiv.net",
        },
        connectTimeout: const Duration(seconds: 6000)
        receiveTimeout: const Duration(seconds: 6000)
        sendTimeout: const Duration(seconds: 6000)
      ),
    );

    dio.interceptors.add(RetryInterceptor(dio, hasMore: false));

    return dio;
  }

  ///client_id 固定不变的
  static const _clientId = 'MOBrBDS8blbauoSck0ZfDbtuzpyT';

  ///client_secret 固定不变的
  static const _clientSecret = 'lsACyCD94FhDUtGTXi3QzcFE2uU1hqtDaKeqrdwj';

  ///刷新token
  Future<UserAccountResult> refreshAuthToken(String refreshToken) async {
    final response = await _httpClient.post<String>('/auth/token', data: {
      'client_id': _clientId,
      'client_secret': _clientSecret,
      'include_policy': true,
      'grant_type': 'refresh_token',
      'refresh_token': refreshToken,
    });
    return UserAccountResult.fromJson(jsonDecode(response.data!));
  }

  ///初始化token
  Future<UserAccountResult> initAccountAuthToken(String code) async {
    final response = await _httpClient.post<String>(
      '/auth/token',
      data: {
        "client_id": _clientId,
        "client_secret": _clientSecret,
        "include_policy": true,
        "grant_type": "authorization_code",
        "code_verifier": codeVerifier,
        'code': code,
        'redirect_uri': 'https://app-api.pixiv.net/web/v1/users/auth/pixiv/callback',
      },
      options: Options(contentType: Headers.formUrlEncodedContentType),
    );

    return UserAccountResult.fromJson(jsonDecode(response.data!));
  }

  static const String _randomKeySet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-._~';
}
