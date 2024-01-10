// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PlaylistsAttribute.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaylistsAttribute _$PlaylistsAttributeFromJson(Map<String, dynamic> json) =>
    PlaylistsAttribute(
      artwork: Artwork.fromJson(json['artwork'] as Map<String, dynamic>),
      curatorName: json['curatorName'] as String,
      description: json['description'] == null
          ? null
          : DescriptionAttribute.fromJson(
              json['description'] as Map<String, dynamic>),
      isChart: json['isChart'] as bool,
      lastModifiedDate: json['lastModifiedDate'] as String?,
      name: json['name'] as String,
      playlistType: json['playlistType'] as String,
      url: json['url'] as String,
      trackTypes: (json['trackTypes'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$PlaylistsAttributeToJson(PlaylistsAttribute instance) =>
    <String, dynamic>{
      'artwork': instance.artwork,
      'curatorName': instance.curatorName,
      'description': instance.description,
      'isChart': instance.isChart,
      'lastModifiedDate': instance.lastModifiedDate,
      'name': instance.name,
      'playlistType': instance.playlistType,
      'url': instance.url,
      'trackTypes': instance.trackTypes,
    };
