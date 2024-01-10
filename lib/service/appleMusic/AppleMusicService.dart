import 'package:apple_music_clone/core/app_export.dart';
import 'package:apple_music_clone/data/AppleMusicToken.dart';
import 'package:apple_music_clone/data/DioClient.dart';
import 'package:apple_music_clone/model/Albums/Albums.dart';
import 'package:apple_music_clone/model/ChartResponse.dart';
import 'package:apple_music_clone/model/Genre.dart';
import 'package:apple_music_clone/model/Playlists.dart';
import 'package:apple_music_clone/model/SearchResult.dart';
import 'package:apple_music_clone/model/Songs.dart';

class AppleMusicService {
  final AppleMusicToken _appleMusicToken = Get.find<AppleMusicToken>();
  final AppleMusicDio appleMusicDio = AppleMusicDio();

  Uri _generateUrl(String url, [Map<String, String>? queryParameters]) {
    String _ = '$url?${Uri.http('bb', '', queryParameters).query}';
    return Uri.parse(_);
  }

  Future<Playlists> getStorefrontPlaylist() async {
    final Map<String, String> queryParameters = {
      "filter[storefront-chart]": _appleMusicToken.countryCode
    };
    final uri = _generateUrl(
        '/v1/catalog/${_appleMusicToken.countryCode}/playlists',
        queryParameters);

    return await appleMusicDio.dio.getUri(uri).then((value) {
      return Playlists.fromJson(value.data['data'][0]);
    });
  }

  Future<ChartResponse> getEditorial({int? limit}) async {
    final Map<String, String> queryParameters = {
      "types": "playlists,albums",
      "with": "cityCharts,dailyGlobalTopCharts",
    };
    if (limit != null) {
      queryParameters.addAll({'limit': "$limit"});
    }

    final uri = _generateUrl(
        '/v1/catalog/${_appleMusicToken.countryCode}/charts', queryParameters);
    return await appleMusicDio.dio.getUri(uri).then((value) {
      return ChartResponse.fromJson(value.data['results']);
    });
  }

  Future<List<Playlists>> getMostPlayedPlaylist({int limit = 10}) async {
    final String url =
        "/v1/catalog/${_appleMusicToken.countryCode}/charts?chart=most-played&limit=$limit&types=playlists";
    return await appleMusicDio.dio
        .getUri(
      Uri.parse(url),
    )
        .then((value) {
      return value.data['results']['playlists'][0]['data']
          .map<Playlists>((x) => Playlists.fromJson(x))
          .toList();
    });
  }

  Future<List<Albums>> getMostPlayedAlbums({int limit = 10}) async {
    final String url =
        "/v1/catalog/${_appleMusicToken.countryCode}/charts?chart=most-played&limit=$limit&types=albums";
    return await appleMusicDio.dio
        .getUri(
      Uri.parse(url),
    )
        .then((value) {
      return value.data['results']['albums'][0]['data']
          .map<Albums>((x) => Albums.fromJson(x))
          .toList();
    });
  }

  Future<List<Songs>> get100TopSongs() async {
    //albums, music-videos, playlists, songs
    final String url =
        "/v1/catalog/${_appleMusicToken.countryCode}/charts?types=songs&limit=100";
    return await appleMusicDio.dio
        .getUri(
      Uri.parse(url),
    )
        .then((value) {
      return value.data['results']['songs'][0]['data']
          .map<Songs>((x) => Songs.fromJson(x))
          .toList();
    });
  }

  Future<List<Genre>> getGenres({int? limit}) async {
    final Map<String, String> queryParameters = {};
    if (limit != null) {
      queryParameters.addAll({'limit': "$limit"});
    }
    final uri = _generateUrl(
        '/v1/catalog/${_appleMusicToken.countryCode}/genres', queryParameters);

    return await appleMusicDio.dio.getUri(uri).then((value) {
      return value.data['data'].map<Genre>((x) => Genre.fromJson(x)).toList();
    });
  }

  Future<List<Playlists>> getPlaylistsByChart(
    String chart, {
    int? limit,
    int? offset,
  }) async {
    final Map<String, String> queryParameters = {
      "types": "playlists",
      "chart": chart // "city-top" // daily-global-top
    };
    if (limit != null) {
      queryParameters.addAll({'limit': "$limit"});
    }
    if (offset != null) {
      queryParameters.addAll({'offset': "$offset"});
    }
    final uri = _generateUrl(
        '/v1/catalog/${_appleMusicToken.countryCode}/charts', queryParameters);
    return await appleMusicDio.dio.getUri(uri).then((value) {
      return value.data['results']['cityCharts'][0]['data']
          .map<Playlists>((x) => Playlists.fromJson(x))
          .toList();
    });
  }

  Future<Playlists> getDataByHref(String href) async {
    return await appleMusicDio.dio.getUri(Uri.parse(href)).then((value) {
      return Playlists.fromJson(value.data['data'][0]);
    });
  }

  Future<Map<String, SearchParam>> searchTerm(String term) async {
    String url =
        "/v1/catalog/MY/search?types=playlists,albums,songs&with=topResults&limit=25&term=$term";
    return await appleMusicDio.dio.getUri(Uri.parse(url)).then((value) {
      return (value.data['results'] as Map<String, dynamic>).map((key, value) {
        return MapEntry(key, SearchParam.fromJsonMixed(value));
      });
    });
  }
}
