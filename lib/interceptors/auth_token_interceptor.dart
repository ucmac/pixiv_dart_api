import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

import '../pixiv_auth.dart';
import '../vo/error_message.dart';
import '../vo/user_account_result.dart';

class AuthTokenInterceptor extends QueuedInterceptorsWrapper {
  final Dio httpClient;
  final PixivAuth auth;

  final UserAccountResult? Function() accountGetter;

  final void Function(UserAccountResult userAccount) accountUpdater;

  AuthTokenInterceptor(this.httpClient, this.auth, this.accountGetter, this.accountUpdater);

  static const authHeaderName = 'Authorization';

  String? getToken() {
    final currentAccount = accountGetter.call();
    if (null == currentAccount) {
      return null;
    }

    final token = currentAccount.accessToken;
    return 'Bearer $token';
  }

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = getToken();
    if (null != token) {
      options.headers[authHeaderName] = token;
    }

    handler.next(options);
  }

  //刷新token最小间隔 1分钟
  static const _refreshTokenMinInterval = 60 * 1000;

  //上次刷新token的时间
  int _refreshTokenLastTime = 0;

  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    if (null == err.response) {
      return handler.reject(err);
    }

    //http 400
    if (HttpStatus.badRequest != err.response!.statusCode) {
      return handler.reject(err);
    }

    final errorMessage = ErrorMessage.fromJson(jsonDecode(err.response!.data));

    final message = errorMessage.error.message!;

    if (!message.contains('OAuth')) {
      return handler.reject(err);
    }

    print('AuthToken错误');

    final currentTime = DateTime.now().millisecondsSinceEpoch;

    if (null == getToken()) {
      return handler.reject(err);
    }

    final option = err.requestOptions;

    //防止连续多个OAuth错误 导致重复刷新token
    if ((currentTime - _refreshTokenLastTime) > _refreshTokenMinInterval) {
      print('需要刷新AuthToken');

      final currentAccount = accountGetter.call()!;

      bool hasError = false;

      await auth.refreshAuthToken(currentAccount.refreshToken).then((result) {
        accountUpdater.call(result);
        _refreshTokenLastTime = currentTime;

        option.headers[authHeaderName] = result.accessToken;
      }).catchError((e) {
        print('刷新AuthToken失败');
        print((e as DioError).response?.data);
        hasError = true;
      });

      QueuedInterceptorsWrapper();
      if (hasError) {
        return handler.reject(err);
      }
    }

    final response = await httpClient.request(
      option.path,
      data: option.data,
      queryParameters: option.queryParameters,
      cancelToken: option.cancelToken,
      options: Options(
        method: option.method,
        headers: option.headers,
        contentType: option.contentType,
      ),
    );

    return handler.resolve(response);
  }
}
