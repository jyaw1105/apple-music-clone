import 'package:apple_music_clone/core/app_export.dart';
import 'package:apple_music_clone/model/Playlists.dart';

class ChartModel {
  final String title = 'Top Songs';
  final Rx<Playlists?> playlists = Rx(null);
  final Rx<String?> errorMessage = Rx(null);
  late final String? href;
  ChartModel({required this.href});
}
