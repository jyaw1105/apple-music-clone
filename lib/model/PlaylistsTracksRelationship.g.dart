// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PlaylistsTracksRelationship.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaylistsTracksRelationship _$PlaylistsTracksRelationshipFromJson(
        Map<String, dynamic> json) =>
    PlaylistsTracksRelationship(
      href: json['href'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Songs.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PlaylistsTracksRelationshipToJson(
        PlaylistsTracksRelationship instance) =>
    <String, dynamic>{
      'href': instance.href,
      'data': instance.data,
    };
