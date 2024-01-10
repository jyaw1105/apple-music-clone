import 'package:apple_music_clone/model/common/Artwork.dart';
import 'package:json_annotation/json_annotation.dart';

part 'AlbumsAttributes.g.dart';

@JsonSerializable()
class AlbumsAttributes {
  final String artistName;
  final Artwork artwork;
  final List<String> genreNames;
  final String? releaseDate;
  final bool isCompilation;
  final bool isComplete;
  final bool isMasteredForItunes;
  final bool isSingle;
  final String name;
  final int trackCount;
  final String url;
  final String? contentRating;

  AlbumsAttributes(
      {required this.artistName,
      required this.artwork,
      required this.genreNames,
      this.releaseDate,
      required this.isCompilation,
      required this.isComplete,
      required this.isMasteredForItunes,
      required this.isSingle,
      required this.name,
      required this.trackCount,
      required this.url,
      this.contentRating});

  factory AlbumsAttributes.fromJson(Map<String, dynamic> json) => _$AlbumsAttributesFromJson(json);

}
