import 'dart:io';

import 'package:pixiv_dart_api/pixiv_web_api.dart';

void main() async {
  HttpOverrides.global = _MyHttpOverrides();
  // final result = await PixivWebApi().getLatestMessagePage(offset: 0, limit: 100);
  // final result = await PixivWebApi().getMessageContentPage(threadId: 33456408, limit: 100);
  final result = await PixivWebApi().getPixivContext();
  print(result);
}

class _MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}
