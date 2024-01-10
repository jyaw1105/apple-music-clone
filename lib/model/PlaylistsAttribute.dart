import 'package:apple_music_clone/model/SongsAttributes.dart';
import 'package:apple_music_clone/model/common/Artwork.dart';
import 'package:apple_music_clone/model/common/DescriptionAttribute.dart';
import 'package:json_annotation/json_annotation.dart';

part 'PlaylistsAttribute.g.dart';

@JsonSerializable()
class PlaylistsAttribute {
  final Artwork artwork;
  final String curatorName;
  final DescriptionAttribute? description;
  final bool isChart;
  final String? lastModifiedDate;
  final String name;
  
  /// Editorial: A playlist created by an Apple Music curator.
  /// External: A playlist created by a non-Apple curator or brand.
  /// Personal-mix: A personalized playlist for an Apple Music user.
  /// Replay: A personalized Apple Music Replay playlist for an Apple Music user.
  /// User-shared: A playlist created and shared by an Apple Music user.
  /// Possible Values: editorial, external, personal-mix, replay, user-shared
  final String playlistType;
  final String url;
  final List<String>? trackTypes;

  PlaylistsAttribute({
    required this.artwork,
    required this.curatorName,
    this.description,
    required this.isChart,
    this.lastModifiedDate,
    required this.name,
    required this.playlistType,
    required this.url,
    this.trackTypes
  });


  factory PlaylistsAttribute.fromJson(Map<String, dynamic> json) =>
      _$PlaylistsAttributeFromJson(json);
}