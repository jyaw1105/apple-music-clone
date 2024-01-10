import 'package:apple_music_clone/config/env.dart';

class AppConfig {
  final Env env;

  const AppConfig({required this.env});
}

class DevAppConfig extends AppConfig {
  DevAppConfig() : super(env: DevEnv());
}

class DummyAppConfig extends AppConfig {
  DummyAppConfig() : super(env: DevEnv());
}
