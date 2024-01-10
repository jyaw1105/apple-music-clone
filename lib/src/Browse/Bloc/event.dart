import 'package:apple_music_clone/model/Playlists.dart';
import 'package:flutter/material.dart';

abstract class BrowseEvent {}

class PlaylistOnTap extends BrowseEvent {
  final Playlists playlists;
  final BuildContext context;
  PlaylistOnTap({required this.playlists, required this.context});
}

class FetchData extends BrowseEvent {}

class FetchStorefront extends BrowseEvent {}

class FetchMostPlaylists extends BrowseEvent {}
