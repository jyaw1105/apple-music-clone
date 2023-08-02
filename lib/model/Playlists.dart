import 'package:apple_music_clone/model/PlaylistsAttribute.dart';
import 'package:apple_music_clone/model/PlaylistsRelationships.dart';
import 'package:apple_music_clone/model/SongsAttributes.dart';
import 'package:json_annotation/json_annotation.dart';

part 'Playlists.g.dart';

@JsonSerializable()
class Playlists {
  final String id;
  final String type;
  final String href;
  final PlaylistsAttribute attributes;
  final PlaylistsRelationships? relationships;

  Playlists({
    required this.id,
    required this.type,
    required this.href,
    required this.attributes,
    this.relationships
  });


  factory Playlists.fromJson(Map<String, dynamic> json) =>
      _$PlaylistsFromJson(json);
}