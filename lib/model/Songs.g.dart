// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Songs.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Songs _$SongsFromJson(Map<String, dynamic> json) => Songs(
      id: json['id'] as String,
      type: json['type'] as String,
      href: json['href'] as String,
      attributes: json['attributes'] == null
          ? null
          : SongsAttributes.fromJson(
              json['attributes'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SongsToJson(Songs instance) => <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'href': instance.href,
      'attributes': instance.attributes,
    };
