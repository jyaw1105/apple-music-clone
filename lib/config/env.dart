import 'package:envied/envied.dart';

part 'env.g.dart';

abstract class Env {
  final String teamID = '';
  final String keyID = '';
  final String privateKey = '';
  final String? developerToken = '';
}

@Envied(name: 'DevEnv', path: '.env.dev')
class DevEnv extends Env {
  @override
  @EnviedField(varName: 'TEAM_ID', obfuscate: true)
  String teamID = _DevEnv.teamID;
  @override
  @EnviedField(varName: 'KEY_ID', obfuscate: true)
  String keyID = _DevEnv.keyID;
  @override
  @EnviedField(varName: 'PRIVATE_KEY', obfuscate: true)
  String privateKey = _DevEnv.privateKey;
}
