import 'package:apple_music_clone/model/PlaylistsTracksRelationship.dart';


import 'package:json_annotation/json_annotation.dart';

part 'PlaylistsRelationships.g.dart';

@JsonSerializable()
class PlaylistsRelationships {
  final PlaylistsTracksRelationship tracks;

  PlaylistsRelationships({
    required this.tracks
  });

  factory PlaylistsRelationships.fromJson(Map<String, dynamic> json) =>
      _$PlaylistsRelationshipsFromJson(json);
}