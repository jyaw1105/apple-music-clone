// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PlaylistsRelationships.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaylistsRelationships _$PlaylistsRelationshipsFromJson(
        Map<String, dynamic> json) =>
    PlaylistsRelationships(
      tracks: PlaylistsTracksRelationship.fromJson(
          json['tracks'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PlaylistsRelationshipsToJson(
        PlaylistsRelationships instance) =>
    <String, dynamic>{
      'tracks': instance.tracks,
    };
