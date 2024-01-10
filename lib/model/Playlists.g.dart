// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Playlists.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Playlists _$PlaylistsFromJson(Map<String, dynamic> json) => Playlists(
      id: json['id'] as String,
      type: json['type'] as String,
      href: json['href'] as String,
      attributes: PlaylistsAttribute.fromJson(
          json['attributes'] as Map<String, dynamic>),
      relationships: json['relationships'] == null
          ? null
          : PlaylistsRelationships.fromJson(
              json['relationships'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PlaylistsToJson(Playlists instance) => <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'href': instance.href,
      'attributes': instance.attributes,
      'relationships': instance.relationships,
    };
