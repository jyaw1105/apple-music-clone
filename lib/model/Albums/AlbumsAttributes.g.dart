// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AlbumsAttributes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AlbumsAttributes _$AlbumsAttributesFromJson(Map<String, dynamic> json) =>
    AlbumsAttributes(
      artistName: json['artistName'] as String,
      artwork: Artwork.fromJson(json['artwork'] as Map<String, dynamic>),
      genreNames: (json['genreNames'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      releaseDate: json['releaseDate'] as String?,
      isCompilation: json['isCompilation'] as bool,
      isComplete: json['isComplete'] as bool,
      isMasteredForItunes: json['isMasteredForItunes'] as bool,
      isSingle: json['isSingle'] as bool,
      name: json['name'] as String,
      trackCount: json['trackCount'] as int,
      url: json['url'] as String,
      contentRating: json['contentRating'] as String?,
    );

Map<String, dynamic> _$AlbumsAttributesToJson(AlbumsAttributes instance) =>
    <String, dynamic>{
      'artistName': instance.artistName,
      'artwork': instance.artwork,
      'genreNames': instance.genreNames,
      'releaseDate': instance.releaseDate,
      'isCompilation': instance.isCompilation,
      'isComplete': instance.isComplete,
      'isMasteredForItunes': instance.isMasteredForItunes,
      'isSingle': instance.isSingle,
      'name': instance.name,
      'trackCount': instance.trackCount,
      'url': instance.url,
      'contentRating': instance.contentRating,
    };
