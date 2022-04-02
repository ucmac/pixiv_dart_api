//Dart的enum 不能有具体值

enum Restrict { public, private }

enum RankingMode {
  ///天
  day,

  ///天 R18
  dayR18,

  ///天 男性欢迎
  dayMale,

  ///天 男性欢迎 R18
  dayMaleR18,

  ///天 女性欢迎
  dayFemale,

  ///天 女性欢迎 R18
  dayFemaleR18,

  ///周
  week,

  ///周 R18
  weekR18,

  ///周(原创)
  weekOriginal,

  ///周(新人)
  weekRookie,

  ///月
  month,
}

enum IllustType {
  ///插画
  illust,

  ///漫画
  manga,
}

enum WorkType {
  ///插画
  illust,

  ///漫画
  manga,

  ///小说
  novel,
}

enum SearchSort {
  ///时间降序(最新)
  dateDesc,

  ///时间升序(最旧)
  dateAsc,

  ///热度降序
  popularDesc,
}

enum SearchTarget {
  ///标签(部分匹配)
  partialMatchForTags,

  ///标签(完全匹配)
  exactMatchForTags,

  ///标签&简介
  titleAndCaption,
}

extension EnumExtension on Enum {
  String toPixivStringParameter() {
    final typeString = this.name.toString();

    final typeValueString = typeString.substring(typeString.indexOf('.') + 1);
    return typeValueString.replaceAllMapped(
      RegExp(r'[A-Z]'),
      (match) {
        return '_${match.input.substring(match.start, match.end)}';
      },
    ).toLowerCase();
  }
}
