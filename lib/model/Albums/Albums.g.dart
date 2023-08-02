// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Albums.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Albums _$AlbumsFromJson(Map<String, dynamic> json) => Albums(
      id: json['id'] as String,
      type: json['type'] as String,
      href: json['href'] as String,
      attributes: json['attributes'] == null
          ? null
          : AlbumsAttributes.fromJson(
              json['attributes'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AlbumsToJson(Albums instance) => <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'href': instance.href,
      'attributes': instance.attributes,
    };
