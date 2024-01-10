import 'package:apple_music_clone/core/app_export.dart';
import 'package:apple_music_clone/data/AppleMusicToken.dart';
import 'package:dio/dio.dart';

class AppleMusicDio {
  final AppleMusicToken _appleMusicToken = Get.find<AppleMusicToken>();

  Map<String, String> get _headers {
    Map<String, String> _ = {}; //(h ?? {});
    _.addAll({
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': "Bearer ${_appleMusicToken.token}"
    });
    return _;
  }

  Dio get dio {
    return Dio(
        BaseOptions(headers: _headers, baseUrl: 'https://api.music.apple.com'));
  }
}
