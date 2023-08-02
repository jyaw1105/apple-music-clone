import 'package:apple_music_clone/model/Playlists.dart';

abstract class BrowseEvent {}

class PlaylistOnTap extends BrowseEvent {
  final Playlists playlists;
  PlaylistOnTap({required this.playlists});
}

class FetchData extends BrowseEvent {}

class FetchStorefront extends BrowseEvent {}

class FetchMostPlaylists extends BrowseEvent {}
