import 'package:apple_music_clone/model/Playlists.dart';

class ChartState {
  final String title;
  final Playlists? playlists;
  final String? errorMessage;

  ChartState({this.errorMessage, String? title, this.playlists})
      : title = title ?? "Top Songs";

  ChartState copyWith(
      {String? title, Playlists? playlists, String? errorMessage}) {
    return ChartState(
        title: title ?? this.title,
        playlists: playlists ?? this.playlists,
        errorMessage: errorMessage ?? this.errorMessage);
  }
}
