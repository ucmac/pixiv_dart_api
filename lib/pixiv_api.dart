import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:pixiv_dart_api/vo/bookmark_detail_result.dart';
import 'package:pixiv_dart_api/vo/live_detail_result.dart';
import 'package:pixiv_dart_api/vo/live_page_result.dart';

import 'enums.dart';
import 'interceptors/auth_token_interceptor.dart';
import 'interceptors/retry_interceptor.dart';
import 'pixiv_auth.dart';
import 'vo/bookmark_tag_page_result.dart';
import 'vo/comment_add_result.dart';
import 'vo/comment_page_result.dart';
import 'vo/error_message.dart';
import 'vo/illust_detail_result.dart';
import 'vo/illust_page_result.dart';
import 'vo/novel_page_result.dart';
import 'vo/page_list.dart';
import 'vo/profile_presets_result.dart';
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
          'User-Agent': 'PixivAndroidApp/6.54.0 (Android 11.0; $deviceName)',
          'App-OS': 'android',
          'App-OS-Version': '11.0',
          'App-Version': '6.54.0',
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
  Future<T> getNextPage<T extends IPageList>(
    String url, {
    required CancelToken cancelToken,
  }) {
    return _httpClient.get<String>(url.replaceFirst("app-api.pixiv.net", targetIPGetter.call()), cancelToken: cancelToken).then((response) {
      final responseData = response.data!;
      if (T == CommentPageResult) {
        return CommentPageResult.fromJson(jsonDecode(responseData)) as T;
      } else if (T == IllustPageResult) {
        return IllustPageResult.fromJson(jsonDecode(responseData)) as T;
      } else if (T == NovelPageResult) {
        return NovelPageResult.fromJson(jsonDecode(responseData)) as T;
      } else if (T == UserPageResult) {
        return UserPageResult.fromJson(jsonDecode(responseData)) as T;
      } else if (T == SearchIllustPageResult) {
        return SearchIllustPageResult.fromJson(jsonDecode(responseData)) as T;
      } else if (T == BookmarkTagPageResult) {
        return BookmarkTagPageResult.fromJson(jsonDecode(responseData)) as T;
      } else if (T == LivePageResult) {
        return LivePageResult.fromJson(jsonDecode(responseData)) as T;
      }
      throw Exception('类型错误');
    });
  }

  ///获取直播列表
  Future<LivePageResult> getLivePage({
    required CancelToken cancelToken,
  }) {
    return _httpClient
        .get<String>(
          'https://${targetIPGetter.call()}/v1/live/list',
          queryParameters: {
            'list_type': 'popular',
          },
          cancelToken: cancelToken,
        )
        .then((response) => LivePageResult.fromJson(jsonDecode(response.data!)));
  }

  ///获取直播详情
  Future<LiveDetailResult> getLiveDetail(
    String id, {
    required CancelToken cancelToken,
  }) {
    return _httpClient
        .get<String>('https://210.140.170.179/api/lives/$id.json',
            cancelToken: cancelToken, options: Options(headers: {'Host': 'sketch.pixiv.net'}))
        .then((response) => LiveDetailResult.fromJson(jsonDecode(response.data!)));
  }

  ///获取用户详细信息 <br/>
  ///如果没有查询到会返回404 : [ErrorMessage.fromJson] => <br/>
  ///[userId] - 用户ID
  Future<UserDetailResult> getUserDetail(
    int userId, {
    required CancelToken cancelToken,
  }) {
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
  }) {
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
  }) {
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
  }) {
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
  }) {
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
  }) {
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
  }) {
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
  }) {
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
  }) {
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
  }) {
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
  }) {
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
  }) {
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

  ///获取好P友 <br/>
  ///[userId] - 用户ID <br/>
  Future<UserPageResult> getMyPixivPage(
    int userId, {
    required CancelToken cancelToken,
  }) {
    return _httpClient
        .get<String>(
          '/v1/user/mypixiv',
          queryParameters: {
            'filter': 'for_android',
            'user_id': userId,
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
  }) {
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

  ///获取好P友的新插画 <br/>
  Future<IllustPageResult> getMyPixivNewIllustPage({
    required CancelToken cancelToken,
  }) {
    return _httpClient
        .get<String>(
          '/v2/illust/mypixiv',
          queryParameters: {
            'filter': 'for_android',
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
  }) {
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

  ///获取好P友的新小说 <br/>
  Future<NovelPageResult> getMyPixivNewNovelPage({
    required CancelToken cancelToken,
  }) {
    return _httpClient
        .get<String>(
          '/v1/novel/mypixiv',
          queryParameters: {
            'filter': 'for_android',
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
  }) {
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
  }) {
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
  }) {
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
  }) {
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
  }) {
    return _httpClient
        .get<String>(
          '/webview/v2/novel',
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
  }) {
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
  }) {
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
  }) {
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
  }) {
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
  ///[target] - 搜索目标([SearchIllustTarget]) <br/>
  ///[startDate] - 开始时间(必须跟[endDate]一起填) <br/>
  ///[endDate] - 结束时间(必须跟[startDate]一起填) <br/>
  ///[bookmarkTotal] - 收藏数量 100, 250, 500, 1000, 5000, 7500 , 10000, 20000, 30000, 50000
  Future<SearchIllustPageResult> getSearchIllustPage(
    String word,
    SearchSort sort,
    SearchIllustTarget target, {
    String? startDate,
    String? endDate,
    int? bookmarkTotal,
    required CancelToken cancelToken,
  }) {
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
  ///[target] - 搜索目标([SearchNovelTarget]) <br/>
  ///[startDate] - 开始时间(必须跟[endDate]一起填) <br/>
  ///[endDate] - 结束时间(必须跟[startDate]一起填) <br/>
  ///[bookmarkTotal] - 收藏数量 100, 250, 500, 1000, 5000, 7500, 10000, 20000, 30000, 50000
  Future<SearchNovelPageResult> getSearchNovelPage(
    String word,
    SearchSort sort,
    SearchNovelTarget target, {
    String? startDate,
    String? endDate,
    int? bookmarkTotal,
    required CancelToken cancelToken,
  }) {
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
  }) {
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
  }) {
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

  ///获取书签详细
  Future<BookmarkDetailResult> getBookmarkDetail({
    required CancelToken cancelToken,
  }) {
    return _httpClient
        .get<String>(
          '/v2/illust/bookmark/detail',
          cancelToken: cancelToken,
        )
        .then((response) => BookmarkDetailResult.fromJson(jsonDecode(response.data!)));
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
  }) {
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
        )
        .then((response) => response.data!);
  }

  ///取消收藏作品 <br/>
  ///[id] - 作品ID <br/>
  ///[isNovel] 小说
  Future<String> postBookmarkDelete(
    int id, {
    bool isNovel = false,
  }) {
    return _httpClient
        .post<String>(
          '/v1/${isNovel ? 'novel' : 'illust'}/bookmark/delete',
          data: FormData.fromMap(
            {
              '${isNovel ? 'novel' : 'illust'}_id': id,
            },
          ),
        )
        .then((response) => response.data!);
  }

  ///关注用户 <br/>
  ///[userId] - 用户ID <br/>
  ///[restrict] 为ture获取公开的(public) 反之不公开(private)
  Future<String> postFollowAdd(
    int userId, {
    Restrict restrict = Restrict.public,
  }) {
    return _httpClient
        .post<String>(
          '/v1/user/follow/add',
          data: FormData.fromMap(
            {
              'user_id': userId,
              'restrict': restrict.toPixivStringParameter(),
            },
          ),
        )
        .then((response) => response.data!);
  }

  ///取消关注用户 <br/>
  ///[userId] - 用户ID
  Future<String> postFollowDelete(int userId) {
    return _httpClient
        .post<String>(
          '/v1/user/follow/delete',
          data: FormData.fromMap(
            {
              'user_id': userId,
            },
          ),
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
    String? comment,
    int? stampId,
    int? parentCommentId,
  }) {
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
        )
        .then((response) => CommentAddResult.fromJson(jsonDecode(response.data!)));
  }

  ///删除评论(自己的) <br/>
  ///[commentId] - 评论ID
  Future<String> postCommentDelete(int commentId) {
    return _httpClient
        .post<String>(
          '/v1/illust/comment/delete',
          data: FormData.fromMap(
            {
              'comment_id': commentId,
            },
          ),
        )
        .then((response) => response.data!);
  }

  ///获取个人资料预设
  Future<ProfilePresetsResult> getProfilePresets({required CancelToken cancelToken}) {
    return _httpClient
        .get<String>(
          '/v1/user/profile/presets',
          cancelToken: cancelToken,
        )
        .then((response) => ProfilePresetsResult.fromJson(jsonDecode(response.data!)));
  }

  ///更新个人资料
  ///
  /// [deleteProfileImage] 删除头像
  ///
  /// [userName] 用户名
  ///
  /// [webpage] 主页
  ///
  /// [twitter] 推特
  ///
  /// [gender] 性别
  ///
  /// [addressId] 地址id
  ///
  /// [countryCode] 国家代码
  ///
  /// [birthday] 生日
  ///
  /// [jobId] 工作id
  ///
  /// [comment] 自我介绍
  ///
  /// [genderPublicity] 性别可见性
  ///
  /// [addressPublicity] 地址可见性
  ///
  /// [birthYearPublicity] 生日年可见性
  ///
  /// [birthDayPublicity] 生日月日可见性
  ///
  /// [jobPublicity] 工作可见性

  Future<String> postProfileEdit({
    required bool deleteProfileImage,
    required Uint8List? profileImageBytes,
    required String? profileImageFilename,
    required String userName,
    required String webpage,
    required String twitter,
    required Gender gender,
    required int addressId,
    required String countryCode,
    required String birthday,
    required int jobId,
    required String comment,
    required Publicity genderPublicity,
    required Publicity addressPublicity,
    required Publicity birthYearPublicity,
    required Publicity birthDayPublicity,
    required Publicity jobPublicity,
  }) {
    final formData = FormData.fromMap(
      {
        'delete_profile_image': deleteProfileImage,
        'user_name': userName,
        'webpage': webpage,
        'twitter': twitter,
        'gender': gender.toPixivStringParameter(),
        'address': addressId,
        'country': countryCode,
        'birthday': birthday,
        'job': jobId,
        'comment': comment,
        'gender_publicity': genderPublicity.toPixivStringParameter(),
        'address_publicity': addressPublicity.toPixivStringParameter(),
        'birth_year_publicity': birthYearPublicity.toPixivStringParameter(),
        'birth_day_publicity': birthDayPublicity.toPixivStringParameter(),
        'job_publicity': jobPublicity.toPixivStringParameter(),
      },
    );
    //根据文件名判断mediaType

    if (null != profileImageBytes) {
      formData
        ..files.add(
          MapEntry(
            'profile_image',
            MultipartFile.fromBytes(
              profileImageBytes,
              filename: profileImageFilename,
              contentType: MediaType('image', profileImageFilename!.split('.').last),
            ),
          ),
        );
    }
    return _httpClient
        .post<String>(
          '/v1/user/profile/edit',
          data: formData,
        )
        .then((response) => response.data!);
  }

  ///更新作业环境
  Future<String> postWorkspaceEdit({
    required UserWorkspace workspace,
  }) {
    return _httpClient
        .post<String>(
          'v1/user/workspace/edit',
          data: FormData.fromMap(workspace.toJson()..removeWhere((key, value) => null == value)),
        )
        .then((response) => response.data!);
  }

  ///添加浏览记录
  ///
  /// [illustIds] 插画id数组
  Future<String> postBrowserHistoryAdd({
    required List<int> illustIds,
  }) {
    return _httpClient
        .post<String>(
          '/v2/user/browsing-history/illust/add',
          data: FormData.fromMap(
            {
              'illust_ids[]': illustIds,
            },
          ),
        )
        .then((response) => response.data!);
  }
}
