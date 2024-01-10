

import 'package:apple_music_clone/model/Albums/Albums.dart';
import 'package:apple_music_clone/model/ChartItem.dart';
import 'package:apple_music_clone/model/Playlists.dart';
import 'package:apple_music_clone/model/Songs.dart';

import 'package:json_annotation/json_annotation.dart';

part 'ChartResponse.g.dart';

@JsonSerializable()
class ChartResponse {
  List<ChartItem<Songs>>? songs;
  List<ChartItem<Playlists>>? cityCharts;
  List<ChartItem<Playlists>>? dailyGlobalTopCharts;
  List<ChartItem<Playlists>>? playlists;
  List<ChartItem<Albums>>? albums;

  ChartResponse({
    this.songs,
    this.cityCharts,
    this.dailyGlobalTopCharts,
    this.playlists,
    this.albums
  });


  factory ChartResponse.fromJson(Map<String, dynamic> json) =>
      _$ChartResponseFromJson(json);
}