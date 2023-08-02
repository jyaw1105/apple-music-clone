
import 'package:apple_music_clone/model/Albums/Albums.dart';
import 'package:apple_music_clone/model/Playlists.dart';
import 'package:apple_music_clone/model/Songs.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ChartItem.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class ChartItem<T> {
  final String name;
  final List<T> data;
  
  ChartItem({
    required this.name,
    required this.data,
  });

  factory ChartItem.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$ChartItemFromJson(json, fromJsonT);
}