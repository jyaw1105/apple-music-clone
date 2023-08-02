import 'dart:developer';

import 'package:apple_music_clone/provider/constant.dart';
import "package:dart_jsonwebtoken/dart_jsonwebtoken.dart";
// import 'package:music_kit/music_kit.dart';

class AppleMusicToken {
  static late String _countryCode;
  static late String _developerToken;
  static late String _userToken;

  // static MusicKit musicKit = MusicKit();

  static Future<void> initPlatformState() async {
    // final status = await musicKit.authorizationStatus;
    // await musicKit.requestAuthorizationStatus();
    // _developerToken = await musicKit.requestDeveloperToken();
    // _userToken = await musicKit.requestUserToken(_developerToken);
    // _countryCode = await musicKit.currentCountryCode;
    _developerToken = token;
    _userToken = "";
    _countryCode = "MY";
  }

  static String get userToken => _userToken;
  static String get developerToken => _developerToken;
  static String get countryCode => _countryCode;

  static String get token {
    if (developerKey.isNotEmpty) {
      return developerKey;
    }
    String token = "";
    final jwt = JWT(
      {
        "iss": teamID,
        "exp": (DateTime.now().millisecondsSinceEpoch / 1000).floor() +
            (60 * 60 * 24)
      },
      header: {"kid": keyID},
      issuer: teamID,
    );
    final key = ECPrivateKey(privateKey);
    token = jwt.sign(key, algorithm: JWTAlgorithm.ES256);
    log('Signed token: $token\n');
    return token;
  }
}
