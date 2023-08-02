import 'package:apple_music_clone/model/Attributes.dart';
import 'package:apple_music_clone/model/common/Artwork.dart';
import 'package:apple_music_clone/model/common/Preview.dart';

import 'package:json_annotation/json_annotation.dart';

part 'SongsAttributes.g.dart';

@JsonSerializable()
class SongsAttributes extends Attributes {
  final String albumName;
  final String artistName;
  final String? artistUrl;
  final Artwork artwork;
  final String? attribution;
  final String? audioVariants;
  final String? composerName;
  final String? contentRating;
  final int? discNumber;
  final int durationInMillis;
  final List<String> genreNames;
  final bool hasLyrics;
  final bool isAppleDigitalMaster;
  final String? isrc;
  final String name;
  final List<Preview> previews;
  final String url;

  SongsAttributes(
      {required this.albumName,
      required this.artistName,
      this.artistUrl,
      required this.artwork,
      this.attribution,
      this.audioVariants,
      this.composerName,
      this.contentRating,
      this.discNumber,
      required this.durationInMillis,
      required this.genreNames,
      required this.hasLyrics,
      required this.isAppleDigitalMaster,
      this.isrc,
      required this.name,
      required this.previews,
      required this.url});

    factory SongsAttributes.fromJson(Map<String, dynamic> json) => _$SongsAttributesFromJson(json);
}
