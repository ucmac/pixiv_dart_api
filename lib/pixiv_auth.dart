/*
 * Copyright (C) 2021. by xiao-cao-x, All rights reserved
 * 项目名称:pixiv_func_mobile
 * 文件名称:pixiv_auth.dart
 * 创建时间:2021/8/21 下午3:42
 * 作者:小草
 */

import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'dto/user_account.dart';
import 'interceptors/retry_interceptor.dart';

class PixivAuth {
  late final String Function() targetIPGetter;
  late final String Function() languageGetter;
  late final String deviceName;

  ///兼容GetX的GetxService
  PixivAuth init(
    String Function() targetIPGetter,
    String Function() languageGetter,
    String deviceName,
  ) {
    this.targetIPGetter = targetIPGetter;
    this.languageGetter = languageGetter;
    this.deviceName = deviceName;
    return this;
  }

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
        connectTimeout: 6 * 1000,
        receiveTimeout: 6 * 1000,
        sendTimeout: 6 * 1000,
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
  Future<UserAccount> refreshAuthToken(String refreshToken) async {
    final response = await _httpClient.post<String>('/auth/token', data: {
      'client_id': _clientId,
      'client_secret': _clientSecret,
      'include_policy': true,
      'grant_type': 'refresh_token',
      'refresh_token': refreshToken,
    });
    return UserAccount.fromJson(jsonDecode(response.data!));
  }

  ///初始化token
  Future<UserAccount> initAccountAuthToken(String code, String codeVerifier) async {
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

    return UserAccount.fromJson(jsonDecode(response.data!));
  }

  static const String _randomKeySet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-._~';

  String randomString(int length) {
    return List.generate(length, (i) => _randomKeySet[Random.secure().nextInt(_randomKeySet.length)]).join();
  }

  String generateCodeChallenge(String s) {
    return base64Url.encode(sha256.convert(ascii.encode(s)).bytes).replaceAll('=', '');
  }
}
