import 'torrents.dart';

/// id : 78113
/// url : "https://yts.gg/movies/sayonara-cp-1972"
/// imdb_code : "tt0234669"
/// title : "Sayônara CP"
/// title_english : "Sayônara CP"
/// title_long : "Sayônara CP (1972)"
/// slug : "sayonara-cp-1972"
/// year : 1972
/// rating : 7.5
/// runtime : 82
/// genres : ["Documentary"]
/// summary : "An intimate documentary about a group of people with cerebral palsy in Japan that confronts our preconceptions and prejudices about who they are, what they feel, and how they view their lives."
/// description_full : "An intimate documentary about a group of people with cerebral palsy in Japan that confronts our preconceptions and prejudices about who they are, what they feel, and how they view their lives."
/// synopsis : "An intimate documentary about a group of people with cerebral palsy in Japan that confronts our preconceptions and prejudices about who they are, what they feel, and how they view their lives."
/// yt_trailer_code : ""
/// language : "ja"
/// mpa_rating : "Not Rated"
/// background_image : "https://yts.gg/assets/images/movies/sayonara_cp_1972/background.jpg"
/// background_image_original : "https://yts.gg/assets/images/movies/sayonara_cp_1972/background.jpg"
/// small_cover_image : "https://yts.gg/assets/images/movies/sayonara_cp_1972/small-cover.jpg"
/// medium_cover_image : "https://yts.gg/assets/images/movies/sayonara_cp_1972/medium-cover.jpg"
/// large_cover_image : "https://yts.gg/assets/images/movies/sayonara_cp_1972/large-cover.jpg"
/// state : "ok"
/// torrents : [{"url":"https://yts.gg/torrent/download/4507202EA33F4E2CBEA4C3A1279649B6A635508F","hash":"4507202EA33F4E2CBEA4C3A1279649B6A635508F","quality":"720p","type":"bluray","is_repack":"0","video_codec":"x264","bit_depth":"8","audio_channels":"2.0","seeds":0,"peers":0,"size":"764.44 MB","size_bytes":801573437,"date_uploaded":"2026-08-24 07:10:28","date_uploaded_unix":1787548228},{"url":"https://yts.gg/torrent/download/EE76B126B748095D9F5964E1218B751476DB6617","hash":"EE76B126B748095D9F5964E1218B751476DB6617","quality":"1080p","type":"bluray","is_repack":"0","video_codec":"x264","bit_depth":"8","audio_channels":"2.0","seeds":0,"peers":0,"size":"1.39 GB","size_bytes":1492501135,"date_uploaded":"2026-08-24 08:12:40","date_uploaded_unix":1787551960}]
/// date_uploaded : "2026-08-24 07:10:28"
/// date_uploaded_unix : 1787548228
class Movies {
  Movies({
    this.id,
    this.url,
    this.imdbCode,
    this.title,
    this.titleEnglish,
    this.titleLong,
    this.slug,
    this.year,
    this.rating,
    this.runtime,
    this.genres,
    this.summary,
    this.descriptionFull,
    this.synopsis,
    this.ytTrailerCode,
    this.language,
    this.mpaRating,
    this.backgroundImage,
    this.backgroundImageOriginal,
    this.smallCoverImage,
    this.mediumCoverImage,
    this.largeCoverImage,
    this.state,
    this.torrents,
    this.dateUploaded,
    this.dateUploadedUnix,});

  Movies.fromJson(dynamic json) {
    id = json['id'];
    url = json['url'];
    imdbCode = json['imdb_code'];
    title = json['title'];
    titleEnglish = json['title_english'];
    titleLong = json['title_long'];
    slug = json['slug'];
    year = json['year'];
    // التعديل السريع والآمن للـ rating
    rating = json['rating'] != null ? (json['rating'] as num).toDouble() : null;
    runtime = json['runtime'];
    genres = json['genres'] != null ? json['genres'].cast<String>() : [];
    summary = json['summary'];
    descriptionFull = json['description_full'];
    synopsis = json['synopsis'];
    ytTrailerCode = json['yt_trailer_code'];
    language = json['language'];
    mpaRating = json['mpa_rating'];
    backgroundImage = json['background_image'];
    backgroundImageOriginal = json['background_image_original'];
    smallCoverImage = json['small_cover_image'];
    mediumCoverImage = json['medium_cover_image'];
    largeCoverImage = json['large_cover_image'];
    state = json['state'];
    if (json['torrents'] != null) {
      torrents = [];
      json['torrents'].forEach((v) {
        torrents?.add(Torrents.fromJson(v));
      });
    }
    dateUploaded = json['date_uploaded'];
    dateUploadedUnix = json['date_uploaded_unix'];
  }
  int? id;
  String? url;
  String? imdbCode;
  String? title;
  String? titleEnglish;
  String? titleLong;
  String? slug;
  int? year;
  double? rating;
  int? runtime;
  List<String>? genres;
  String? summary;
  String? descriptionFull;
  String? synopsis;
  String? ytTrailerCode;
  String? language;
  String? mpaRating;
  String? backgroundImage;
  String? backgroundImageOriginal;
  String? smallCoverImage;
  String? mediumCoverImage;
  String? largeCoverImage;
  String? state;
  List<Torrents>? torrents;
  String? dateUploaded;
  int? dateUploadedUnix;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['url'] = url;
    map['imdb_code'] = imdbCode;
    map['title'] = title;
    map['title_english'] = titleEnglish;
    map['title_long'] = titleLong;
    map['slug'] = slug;
    map['year'] = year;
    map['rating'] = rating;
    map['runtime'] = runtime;
    map['genres'] = genres;
    map['summary'] = summary;
    map['description_full'] = descriptionFull;
    map['synopsis'] = synopsis;
    map['yt_trailer_code'] = ytTrailerCode;
    map['language'] = language;
    map['mpa_rating'] = mpaRating;
    map['background_image'] = backgroundImage;
    map['background_image_original'] = backgroundImageOriginal;
    map['small_cover_image'] = smallCoverImage;
    map['medium_cover_image'] = mediumCoverImage;
    map['large_cover_image'] = largeCoverImage;
    map['state'] = state;
    if (torrents != null) {
      map['torrents'] = torrents?.map((v) => v.toJson()).toList();
    }
    map['date_uploaded'] = dateUploaded;
    map['date_uploaded_unix'] = dateUploadedUnix;
    return map;
  }

}