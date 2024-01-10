import 'dart:io';

import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:apple_music_clone/core/app_export.dart';
import 'package:apple_music_clone/config/app_config.dart';
import 'package:apple_music_clone/data/AppleMusicToken.dart';
import 'package:apple_music_clone/service/appleMusic/PlayService.dart';

class InitialBindingsAsync extends Bindings {
  InitialBindingsAsync();

  @override
  Future<void> dependencies() async {
    if (Platform.isIOS) {
      try {
        await AppTrackingTransparency.requestTrackingAuthorization();
      } catch (e) {}
    }
    // await Get.putAsync<LocalizationService>(LocalizationService().init,
    //     permanent: true);
    // imageCache.clear();
  }
}

class InitialBindings extends Bindings {
  final AppConfig appConfig;

  InitialBindings({required this.appConfig});

  @override
  void dependencies() {
    Get.put(AppleMusicToken(appConfig));
    Connectivity connectivity = Connectivity();
    Get.put(NetworkInfo(connectivity));
    Get.put(PlayController(PlayControllerModel()));
  }
}
