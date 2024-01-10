import 'package:apple_music_clone/model/Songs.dart';
import 'package:json_annotation/json_annotation.dart';

part 'PlaylistsTracksRelationship.g.dart';

@JsonSerializable()
class PlaylistsTracksRelationship {
  final String? href;
  final List<Songs>? data;
  PlaylistsTracksRelationship({
    required this.href,
    this.data
  });

  factory PlaylistsTracksRelationship.fromJson(Map<String, dynamic> json) =>
      _$PlaylistsTracksRelationshipFromJson(json);

}