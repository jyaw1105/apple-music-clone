// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SongsAttributes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SongsAttributes _$SongsAttributesFromJson(Map<String, dynamic> json) =>
    SongsAttributes(
      albumName: json['albumName'] as String,
      artistName: json['artistName'] as String,
      artistUrl: json['artistUrl'] as String?,
      artwork: Artwork.fromJson(json['artwork'] as Map<String, dynamic>),
      attribution: json['attribution'] as String?,
      audioVariants: json['audioVariants'] as String?,
      composerName: json['composerName'] as String?,
      contentRating: json['contentRating'] as String?,
      discNumber: json['discNumber'] as int?,
      durationInMillis: json['durationInMillis'] as int,
      genreNames: (json['genreNames'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      hasLyrics: json['hasLyrics'] as bool,
      isAppleDigitalMaster: json['isAppleDigitalMaster'] as bool,
      isrc: json['isrc'] as String?,
      name: json['name'] as String,
      previews: (json['previews'] as List<dynamic>)
          .map((e) => Preview.fromJson(e as Map<String, dynamic>))
          .toList(),
      url: json['url'] as String,
    );

Map<String, dynamic> _$SongsAttributesToJson(SongsAttributes instance) =>
    <String, dynamic>{
      'albumName': instance.albumName,
      'artistName': instance.artistName,
      'artistUrl': instance.artistUrl,
      'artwork': instance.artwork,
      'attribution': instance.attribution,
      'audioVariants': instance.audioVariants,
      'composerName': instance.composerName,
      'contentRating': instance.contentRating,
      'discNumber': instance.discNumber,
      'durationInMillis': instance.durationInMillis,
      'genreNames': instance.genreNames,
      'hasLyrics': instance.hasLyrics,
      'isAppleDigitalMaster': instance.isAppleDigitalMaster,
      'isrc': instance.isrc,
      'name': instance.name,
      'previews': instance.previews,
      'url': instance.url,
    };
