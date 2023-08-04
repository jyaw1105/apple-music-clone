import 'package:apple_music_clone/data/AppleMusicToken.dart';
import 'package:dio/dio.dart';

class AppleMusicDio {
  Map<String, String> get _headers {
    Map<String, String> _ = {}; //(h ?? {});
    _.addAll({
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': "Bearer ${AppleMusicToken.token}"
    });
    return _;
  }

  Dio get dio {
    return Dio(
        BaseOptions(headers: _headers, baseUrl: 'https://api.music.apple.com'));
  }
}
