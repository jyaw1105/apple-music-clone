import 'dart:developer';

import 'package:apple_music_clone/config/app_config.dart';
import "package:dart_jsonwebtoken/dart_jsonwebtoken.dart";
// import 'package:music_kit/music_kit.dart';

class AppleMusicToken {
  final String countryCode = "MY";
  // static final String _developerToken = token;
  final String _userToken = "";

  final AppConfig appConfig;
  AppleMusicToken(this.appConfig);

  // static MusicKit musicKit = MusicKit();

  Future<void> initPlatformState() async {
    // final status = await musicKit.authorizationStatus;
    // await musicKit.requestAuthorizationStatus();
    // _developerToken = await musicKit.requestDeveloperToken();
    // _userToken = await musicKit.requestUserToken(_developerToken);
    // _countryCode = await musicKit.currentCountryCode;
    // _developerToken = token;
    // _userToken = "";
    // _countryCode = "MY";
  }

  // String get userToken => _userToken;
  // String get developerToken => _developerToken;
  // String get countryCode => _countryCode;

  String get token {
    if ((appConfig.env.developerToken ?? '').isNotEmpty) {
      return appConfig.env.developerToken!;
    }
    String token = "";
    final jwt = JWT(
      {
        "iss": appConfig.env.teamID,
        "exp": (DateTime.now().millisecondsSinceEpoch / 1000).floor() +
            (60 * 60 * 24)
      },
      header: {"kid": appConfig.env.keyID},
      issuer: appConfig.env.teamID,
    );
    final key = ECPrivateKey(appConfig.env.privateKey.replaceAll("\\\\n", '\n'));
    token = jwt.sign(key, algorithm: JWTAlgorithm.ES256);
    log('Signed token: $token\n');
    return token;
  }
}
