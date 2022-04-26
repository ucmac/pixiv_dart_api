/*
 * Copyright (C) 2021. by xiao-cao-x, All rights reserved
 * 项目名称:pixiv_func_mobile
 * 文件名称:pixiv_api.dart
 * 创建时间:2021/8/21 下午12:47
 * 作者:小草
 */

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:pixiv_dart_api/vo/comment_add_result.dart';

import 'enums.dart';
import 'interceptors/auth_token_interceptor.dart';
import 'interceptors/retry_interceptor.dart';
import 'pixiv_auth.dart';
import 'vo/bookmark_tag_page_result.dart';
import 'vo/comment_page_result.dart';
import 'vo/error_message.dart';
import 'vo/illust_detail_result.dart';
import 'vo/illust_page_result.dart';
import 'vo/novel_page_result.dart';
import 'vo/search_autocomplete_result.dart';
import 'vo/search_illust_page_result.dart';
import 'vo/search_novel_page_result.dart';
import 'vo/trending_tag_list_result.dart';
import 'vo/ugoira_metadata_result.dart';
import 'vo/user_account_result.dart';
import 'vo/user_detail_result.dart';
import 'vo/user_page_result.dart';

class PixivApi {
  late final PixivAuth auth;
  late final String Function() targetIPGetter;
  late final String Function() languageGetter;
  late final String deviceName;
  late final UserAccountResult? Function() accountGetter;
  late final void Function(UserAccountResult userAccount) accountUpdater;

  ///兼容GetX的GetxService
  PixivApi init({
    required PixivAuth auth,
    required String Function() targetIPGetter,
    required String Function() languageGetter,
    required String deviceName,
    required UserAccountResult? Function() accountGetter,
    required void Function(UserAccountResult userAccount) accountUpdater,
  }) {
    this.auth = auth;
    this.targetIPGetter = targetIPGetter;
    this.languageGetter = languageGetter;
    this.deviceName = deviceName;
    this.accountGetter = accountGetter;
    this.accountUpdater = accountUpdater;
    return this;
  }

  Dio get _httpClient {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://${targetIPGetter.call()}',
        responseType: ResponseType.plain,
        headers: {
          'User-Agent': 'PixivAndroidApp/6.21.1 (Android 11.0; $deviceName)',
          'App-OS': 'android',
          'App-OS-Version': '11.0',
          'App-Version': '6.21.1',
          'Accept-Language': languageGetter.call(),
          'Host': "app-api.pixiv.net"
        },
        connectTimeout: 5 * 1000,
        receiveTimeout: 5 * 1000,
        sendTimeout: 5 * 1000,
      ),
    );
    dio.interceptors.addAll(
      [
        RetryInterceptor(dio, hasMore: true),
        AuthTokenInterceptor(dio, auth, accountGetter, accountUpdater),
      ],
    );
    return dio;
  }

  ///下一页
  Future<T> getNextPageList<T>(
    String url, {
    required CancelToken cancelToken,
  }) async {
    return _httpClient
        .get<String>(
      url.replaceFirst("app-api.pixiv.net", targetIPGetter.call()),
      cancelToken: cancelToken,
    )
        .then((response) {
      final responseData = response.data!;
      if (T == CommentPageResult) {
        return CommentPageResult.fromJson(jsonDecode(responseData)) as T;
      }
      if (T == IllustPageResult) {
        return IllustPageResult.fromJson(jsonDecode(responseData)) as T;
      }
      if (T == NovelPageResult) {
        return NovelPageResult.fromJson(jsonDecode(responseData)) as T;
      }
      if (T == UserPageResult) {
        return UserPageResult.fromJson(jsonDecode(responseData)) as T;
      }
      if (T == SearchIllustPageResult) {
        return SearchIllustPageResult.fromJson(jsonDecode(responseData)) as T;
      }
      if (T == BookmarkTagPageResult) {
        return BookmarkTagPageResult.fromJson(jsonDecode(responseData)) as T;
      }
      throw Exception('类型错误');
    });
  }

  ///获取用户详细信息 <br/>
  ///如果没有查询到会返回404 : [ErrorMessage.fromJson] => <br/>
  ///[userId] - 用户ID
  Future<UserDetailResult> getUserDetail(
    int userId, {
    required CancelToken cancelToken,
  }) async {
    return _httpClient
        .get<String>(
          '/v1/user/detail',
          queryParameters: {
            'filter': 'for_android',
            'user_id': userId,
          },
          cancelToken: cancelToken,
        )
        .then((response) => UserDetailResult.fromJson(jsonDecode(response.data!)));
  }

  ///获取用户收藏的插画 <br/>
  ///[userId] - 用户ID <br/>
  Future<IllustPageResult> getUserIllustBookmarkPage(
    int userId, {
    Restrict restrict = Restrict.public,
    required CancelToken cancelToken,
  }) async {
    return _httpClient
        .get<String>(
          '/v1/user/bookmarks/illust',
          queryParameters: {
            'user_id': userId,
            'restrict': restrict.toPixivStringParameter(),
          },
          cancelToken: cancelToken,
        )
        .then((response) => IllustPageResult.fromJson(jsonDecode(response.data!)));
  }

  ///获取用户收藏的小说 <br/>
  ///[userId] - 用户ID <br/>
  Future<NovelPageResult> getUserNovelBookmarkPage(
    int userId, {
    Restrict restrict = Restrict.public,
    required CancelToken cancelToken,
  }) async {
    return _httpClient
        .get<String>(
          '/v1/user/bookmarks/novel',
          queryParameters: {
            'user_id': userId,
            'restrict': restrict.toPixivStringParameter(),
          },
          cancelToken: cancelToken,
        )
        .then((response) => NovelPageResult.fromJson(jsonDecode(response.data!)));
  }

  ///获取用户的插画 <br/>
  ///[userId] - 用户ID <br/>
  ///[type] - 类型([WorkType])
  Future<IllustPageResult> getUserIllustPage(
    int userId,
    IllustType type, {
    required CancelToken cancelToken,
  }) async {
    return _httpClient
        .get<String>(
          '/v1/user/illusts',
          queryParameters: {
            'filter': 'for_android',
            'user_id': userId,
            'type': type.toPixivStringParameter(),
          },
          cancelToken: cancelToken,
        )
        .then((response) => IllustPageResult.fromJson(jsonDecode(response.data!)));
  }

  ///获取用户的小说 <br/>
  ///[userId] - 用户ID <br/>
  Future<NovelPageResult> getUserNovelPage(
    int userId, {
    required CancelToken cancelToken,
  }) async {
    return _httpClient
        .get<String>(
          '/v1/user/novels',
          queryParameters: {
            'user_id': userId,
          },
          cancelToken: cancelToken,
        )
        .then((response) => NovelPageResult.fromJson(jsonDecode(response.data!)));
  }

  ///获取推荐插画 <br/>
  ///[type] - 类型([IllustType])
  Future<IllustPageResult> getRecommendedIllustPage(
    IllustType type, {
    required CancelToken cancelToken,
  }) async {
    return _httpClient
        .get<String>(
          '/v1/${type.toPixivStringParameter()}/recommended',
          queryParameters: {
            'filter': 'for_android',
          },
          cancelToken: cancelToken,
        )
        .then((response) => IllustPageResult.fromJson(jsonDecode(response.data!)));
  }

  ///获取推荐小说
  Future<NovelPageResult> getRecommendedNovelPage({
    required CancelToken cancelToken,
  }) async {
    return _httpClient
        .get<String>(
          '/v1/novel/recommended',
          queryParameters: {
            'include_ranking_novels': false,
            'include_privacy_policy': false,
          },
          cancelToken: cancelToken,
        )
        .then((response) => NovelPageResult.fromJson(jsonDecode(response.data!)));
  }

  ///获取排行榜 <br/>
  ///[mode] - 方式([RankingMode])
  Future<IllustPageResult> getRankingPage(
    RankingMode mode, {
    required CancelToken cancelToken,
  }) async {
    return _httpClient
        .get<String>(
          '/v1/illust/ranking',
          queryParameters: {
            'filter': 'for_android',
            'mode': mode.toPixivStringParameter(),
          },
          cancelToken: cancelToken,
        )
        .then((response) => IllustPageResult.fromJson(jsonDecode(response.data!)));
  }

  ///获取推荐标签(搜索用的)
  Future<TrendingTagListResult> getTrendingTagList({
    required CancelToken cancelToken,
  }) async {
    return _httpClient
        .get<String>(
          '/v1/trending-tags/illust',
          queryParameters: {
            'filter': 'for_android',
          },
          cancelToken: cancelToken,
        )
        .then((response) => TrendingTagListResult.fromJson(jsonDecode(response.data!)));
  }

  ///获取推荐用户
  Future<UserPageResult> getRecommendedUserPage({
    required CancelToken cancelToken,
  }) async {
    return _httpClient
        .get<String>(
          '/v1/user/recommended',
          queryParameters: {
            'filter': 'for_android',
          },
          cancelToken: cancelToken,
        )
        .then((response) => UserPageResult.fromJson(jsonDecode(response.data!)));
  }

  ///获取粉丝
  Future<UserPageResult> getFollowerPage(
    int userId, {
    required CancelToken cancelToken,
  }) async {
    return _httpClient
        .get<String>(
          '/v1/user/follower',
          queryParameters: {
            'filter': 'for_android',
            'user_id': userId,
          },
          cancelToken: cancelToken,
        )
        .then((response) => UserPageResult.fromJson(jsonDecode(response.data!)));
  }

  ///获取关注用户 <br/>
  ///[userId] - 用户ID <br/>
  Future<UserPageResult> getFollowingUserPage(
    int userId, {
    Restrict restrict = Restrict.public,
    required CancelToken cancelToken,
  }) async {
    return _httpClient
        .get<String>(
          '/v1/user/following',
          queryParameters: {
            'filter': 'for_android',
            'user_id': userId,
            'restrict': restrict.toPixivStringParameter(),
          },
          cancelToken: cancelToken,
        )
        .then((response) => UserPageResult.fromJson(jsonDecode(response.data!)));
  }

  ///获取关注者的新插画 <br/>
  ///[restrict] - 为ture获取公开的(public) 反之不公开(private) null(全部)
  Future<IllustPageResult> getFollowNewIllustPage({
    required Restrict? restrict,
    required CancelToken cancelToken,
  }) async {
    return _httpClient
        .get<String>(
          '/v2/illust/follow',
          queryParameters: {
            'filter': 'for_android',
            'restrict': null == restrict ? 'all' : restrict.toPixivStringParameter(),
          },
          cancelToken: cancelToken,
        )
        .then((response) => IllustPageResult.fromJson(jsonDecode(response.data!)));
  }

  ///获取关注者的新小说 <br/>
  ///[restrict] - 为ture获取公开的(public) 反之不公开(private) null(全部)
  Future<NovelPageResult> getFollowNewNovelPage({
    required Restrict? restrict,
    required CancelToken cancelToken,
  }) async {
    return _httpClient
        .get<String>(
          '/v1/novel/follow',
          queryParameters: {
            'filter': 'for_android',
            'restrict': null == restrict ? 'all' : restrict.toPixivStringParameter(),
          },
          cancelToken: cancelToken,
        )
        .then((response) => NovelPageResult.fromJson(jsonDecode(response.data!)));
  }

  ///获取最近发布的插画 <br/>
  ///[type] - 类型([IllustType])
  Future<IllustPageResult> getNewIllustPage(
    IllustType type, {
    required CancelToken cancelToken,
  }) async {
    return _httpClient
        .get<String>(
          '/v1/illust/new',
          queryParameters: {
            'filter': 'for_android',
            'content_type': type.toPixivStringParameter(),
          },
          cancelToken: cancelToken,
        )
        .then((response) => IllustPageResult.fromJson(jsonDecode(response.data!)));
  }

  ///获取最近发布的小说
  Future<NovelPageResult> getNewNovelPage({
    required CancelToken cancelToken,
  }) async {
    return _httpClient
        .get<String>(
          '/v1/novel/new',
          cancelToken: cancelToken,
        )
        .then((response) => NovelPageResult.fromJson(jsonDecode(response.data!)));
  }

  ///获取插画的相关推荐 <br/>
  ///[illustId] - 插画ID
  Future<IllustPageResult> getIllustRelatedPage(
    int illustId, {
    required CancelToken cancelToken,
  }) async {
    return _httpClient
        .get<String>(
          '/v2/illust/related',
          queryParameters: {
            'filter': 'for_android',
            'illust_id': illustId,
          },
          cancelToken: cancelToken,
        )
        .then((response) => IllustPageResult.fromJson(jsonDecode(response.data!)));
  }

  ///获取插画详细 <br/>
  ///如果没有查询到会返回404 : [ErrorMessage.fromJson] => <br/>
  ///[illustId] - 插画ID
  Future<IllustDetailResult> getIllustDetail(
    int illustId, {
    required CancelToken cancelToken,
  }) async {
    return _httpClient
        .get<String>(
          '/v1/illust/detail',
          queryParameters: {
            'filter': 'for_android',
            'illust_id': illustId,
          },
          cancelToken: cancelToken,
        )
        .then((response) => IllustDetailResult.fromJson(jsonDecode(response.data!)));
  }

  ///获取小说HTML页面 <br/>
  ///[novelId] - 小说ID
  Future<String> getNovelHtml(
    int novelId, {
    required CancelToken cancelToken,
  }) async {
    return _httpClient
        .get<String>(
          '/webview/v1/novel',
          queryParameters: {
            'id': novelId,
          },
          cancelToken: cancelToken,
        )
        .then((response) => response.data!);
  }

  ///获取动图
  ///[illustId] 插画ID
  Future<UgoiraMetadataResult> getUgoiraMetadata(
    int illustId, {
    required CancelToken cancelToken,
  }) async {
    return _httpClient
        .get<String>(
          '/v1/ugoira/metadata',
          queryParameters: {
            'illust_id': illustId,
          },
          cancelToken: cancelToken,
        )
        .then((response) => UgoiraMetadataResult.fromJson(jsonDecode(response.data!)));
  }

  ///获取评论的回复 <br/>
  ///[commentId] - 评论ID
  Future<CommentPageResult> getCommentReplyPage(
    int commentId, {
    required CancelToken cancelToken,
  }) async {
    return _httpClient
        .get<String>(
          '/v2/illust/comment/replies',
          queryParameters: {
            'comment_id': commentId,
          },
          cancelToken: cancelToken,
        )
        .then((response) => CommentPageResult.fromJson(jsonDecode(response.data!)));
  }

  ///获取插画的评论 <br/>
  ///[illustId] - 插画ID
  Future<CommentPageResult> getIllustCommentPage(
    int illustId, {
    required CancelToken cancelToken,
  }) async {
    return _httpClient
        .get<String>(
          '/v3/illust/comments',
          queryParameters: {
            'illust_id': illustId,
          },
          cancelToken: cancelToken,
        )
        .then((response) => CommentPageResult.fromJson(jsonDecode(response.data!)));
  }

  ///**搜索**的**关键字**自动补全 <br/>
  ///[word] - 关键字
  Future<SearchAutocompleteResult> getSearchAutocomplete(
    String word, {
    required CancelToken cancelToken,
  }) async {
    return _httpClient
        .get<String>(
          '/v2/search/autocomplete',
          queryParameters: {
            'merge_plain_keyword_results': true,
            'word': word,
          },
          cancelToken: cancelToken,
        )
        .then((response) => SearchAutocompleteResult.fromJson(jsonDecode(response.data!)));
  }

  ///搜索 <br/>
  ///[word] - 关键字 <br/>
  ///[sort] - 排序([SearchSort]) <br/>
  ///[target] - 搜索目标([SearchTarget]) <br/>
  ///[startDate] - 开始时间(必须跟[endDate]一起填) <br/>
  ///[endDate] - 结束时间(必须跟[startDate]一起填) <br/>
  ///[bookmarkTotal] - 收藏数量 100, 250, 500, 1000, 5000, 7500 , 10000, 20000, 30000, 50000
  Future<SearchIllustPageResult> getSearchIllustPage(
    String word,
    SearchSort sort,
    SearchTarget target, {
    String? startDate,
    String? endDate,
    int? bookmarkTotal,
    required CancelToken cancelToken,
  }) async {
    return _httpClient
        .get<String>(
          '/v1/search/illust',
          queryParameters: {
            'filter': 'for_android',
            'include_translated_tag_results': true,
            'merge_plain_keyword_results': true,
            'word': null != bookmarkTotal ? '$word ${bookmarkTotal}users入り' : word,
            'sort': sort.toPixivStringParameter(),
            'search_target': target.toPixivStringParameter(),
            'start_date': startDate,
            'end_date': endDate,
          }..removeWhere((key, value) => null == value),
          cancelToken: cancelToken,
        )
        .then((response) => SearchIllustPageResult.fromJson(jsonDecode(response.data!)));
  }

  ///搜索 <br/>
  ///[word] - 关键字 <br/>
  ///[sort] - 排序([SearchSort]) <br/>
  ///[target] - 搜索目标([SearchTarget]) <br/>
  ///[startDate] - 开始时间(必须跟[endDate]一起填) <br/>
  ///[endDate] - 结束时间(必须跟[startDate]一起填) <br/>
  ///[bookmarkTotal] - 收藏数量 100, 250, 500, 1000, 5000, 7500, 10000, 20000, 30000, 50000
  Future<SearchNovelPageResult> getSearchNovelPage(
    String word,
    SearchSort sort,
    SearchTarget target, {
    String? startDate,
    String? endDate,
    int? bookmarkTotal,
    required CancelToken cancelToken,
  }) async {
    return _httpClient
        .get<String>(
          '/v1/search/novel',
          queryParameters: {
            'include_translated_tag_results': true,
            'merge_plain_keyword_results': true,
            'word': null != bookmarkTotal ? '$word ${bookmarkTotal}users入り' : word,
            'sort': sort.toPixivStringParameter(),
            'search_target': target.toPixivStringParameter(),
            'start_date': startDate,
            'end_date': endDate,
          }..removeWhere((key, value) => null == value),
          cancelToken: cancelToken,
        )
        .then((response) => SearchNovelPageResult.fromJson(jsonDecode(response.data!)));
  }

  ///搜索用户
  ///[word] - 关键字
  Future<UserPageResult> getSearchUserPage(
    String word, {
    required CancelToken cancelToken,
  }) async {
    return _httpClient
        .get<String>(
          '/v1/search/user',
          queryParameters: {
            'filter': 'for_android',
            'word': word,
          },
          cancelToken: cancelToken,
        )
        .then((response) => UserPageResult.fromJson(jsonDecode(response.data!)));
  }

  ///获取收藏标签
  ///[userId] - 用户ID
  ///[isNovel] - 小说
  Future<BookmarkTagPageResult> getBookmarkTagPage(
    int userId, {
    Restrict restrict = Restrict.public,
    bool isNovel = false,
    required CancelToken cancelToken,
  }) async {
    return _httpClient
        .get<String>(
          '/v1/user/bookmark-tags/${isNovel ? 'novel' : 'illust'}',
          queryParameters: {
            'user_id': userId,
            'restrict': restrict.toPixivStringParameter(),
          },
          cancelToken: cancelToken,
        )
        .then((response) => BookmarkTagPageResult.fromJson(jsonDecode(response.data!)));
  }

  ///收藏作品 <br/>
  ///[id] - 作品ID <br/>
  ///[tags] - 标签(自己添加的) <br/>
  ///[isNovel] - 小说
  Future<String> postBookmarkAdd(
    int id, {
    List<String> tags = const [],
    Restrict restrict = Restrict.public,
    bool isNovel = false,
    required CancelToken cancelToken,
  }) async {
    return _httpClient
        .post<String>(
          '/v2/${isNovel ? 'novel' : 'illust'}/bookmark/add',
          data: FormData.fromMap(
            {
              '${isNovel ? 'novel' : 'illust'}_id': id,
              'restrict': restrict.toPixivStringParameter(),
              'tags': tags,
            },
          ),
          cancelToken: cancelToken,
        )
        .then((response) => response.data!);
  }

  ///取消收藏作品 <br/>
  ///[id] - 作品ID <br/>
  ///[isNovel] 小说
  Future<String> postBookmarkDelete(
    int id, {
    bool isNovel = false,
    required CancelToken cancelToken,
  }) async {
    return _httpClient
        .post<String>(
          '/v1/${isNovel ? 'novel' : 'illust'}/bookmark/delete',
          data: FormData.fromMap(
            {
              '${isNovel ? 'novel' : 'illust'}_id': id,
            },
          ),
          cancelToken: cancelToken,
        )
        .then((response) => response.data!);
  }

  ///关注用户 <br/>
  ///[userId] - 用户ID <br/>
  ///[restrict] 为ture获取公开的(public) 反之不公开(private)
  Future<String> postFollowAdd(
    int userId, {
    Restrict restrict = Restrict.public,
    required CancelToken cancelToken,
  }) async {
    return _httpClient
        .post<String>(
          '/v1/user/follow/add',
          data: FormData.fromMap(
            {
              'user_id': userId,
              'restrict': restrict.toPixivStringParameter(),
            },
          ),
          cancelToken: cancelToken,
        )
        .then((response) => response.data!);
  }

  ///取消关注用户 <br/>
  ///[userId] - 用户ID
  Future<String> postFollowDelete(
    int userId, {
    required CancelToken cancelToken,
  }) async {
    return _httpClient
        .post<String>(
          '/v1/user/follow/delete',
          data: FormData.fromMap(
            {
              'user_id': userId,
            },
          ),
          cancelToken: cancelToken,
        )
        .then((response) => response.data!);
  }

  ///添加评论(评论一个插画) <br/>
  ///[illustId] - 插画ID <br/>
  ///[comment] - 评论内容 <br/>
  ///[stampId] - 表情包ID <br/>
  ///[parentCommentId] - 父评论ID(用来回复)
  Future<CommentAddResult> postCommentAdd(
    int illustId, {
    String comment = '',
    int? stampId,
    int? parentCommentId,
    required CancelToken cancelToken,
  }) async {
    return _httpClient
        .post<String>(
          '/v1/illust/comment/add',
          data: FormData.fromMap(
            {
              'illust_id': illustId,
              'comment': comment,
              'stamp_id': stampId,
              'parent_comment_id': parentCommentId,
            }..removeWhere((key, value) => null == value),
          ),
          cancelToken: cancelToken,
        )
        .then((response) => CommentAddResult.fromJson(jsonDecode(response.data!)));
  }

  ///删除评论(自己的) <br/>
  ///[commentId] - 评论ID
  Future<String> postCommentDelete(
    int commentId, {
    required CancelToken cancelToken,
  }) async {
    return _httpClient
        .post<String>(
          '/v1/illust/comment/delete',
          data: FormData.fromMap(
            {
              'comment_id': commentId,
            },
          ),
          cancelToken: cancelToken,
        )
        .then((response) => response.data!);
  }
}
