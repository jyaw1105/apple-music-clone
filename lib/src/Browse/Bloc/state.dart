import 'package:apple_music_clone/model/ChartResponse.dart';
import 'package:apple_music_clone/model/Playlists.dart';
import 'package:apple_music_clone/model/Songs.dart';

class BrowseState {
  final List<Songs> topSongs;
  final ChartResponse? charts;
  final Playlists? storefront;
  final List<Playlists>? mostPlaylists;
  List<Playlists>? storefronts;

  BrowseState(
      {List<Songs>? topSongs,
      this.charts,
      this.storefront,
      this.mostPlaylists,
      this.storefronts})
      : topSongs = topSongs ?? [];

  BrowseState copyWith(
      {List<Songs>? topSongs,
      ChartResponse? charts,
      Playlists? storefront,
      List<Playlists>? mostPlaylists,
      List<Playlists>? storefronts}) {
    return BrowseState(
        topSongs: topSongs ?? this.topSongs,
        charts: charts ?? this.charts,
        storefront: storefront ?? this.storefront,
        storefronts: storefronts ?? this.storefronts,
        mostPlaylists: mostPlaylists ?? this.mostPlaylists);
  }
}
