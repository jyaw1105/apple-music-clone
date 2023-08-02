// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Genre.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Genre _$GenreFromJson(Map<String, dynamic> json) => Genre(
      id: json['id'] as String,
      href: json['href'] as String,
      attributes:
          GenreAttribute.fromJson(json['attributes'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GenreToJson(Genre instance) => <String, dynamic>{
      'id': instance.id,
      'href': instance.href,
      'attributes': instance.attributes,
    };

GenreAttribute _$GenreAttributeFromJson(Map<String, dynamic> json) =>
    GenreAttribute(
      parentName: json['parentName'] as String?,
      name: json['name'] as String,
      parentId: json['parentId'] as String?,
    );

Map<String, dynamic> _$GenreAttributeToJson(GenreAttribute instance) =>
    <String, dynamic>{
      'parentName': instance.parentName,
      'name': instance.name,
      'parentId': instance.parentId,
    };
