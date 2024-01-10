// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Preview.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Preview _$PreviewFromJson(Map<String, dynamic> json) => Preview(
      artwork: json['artwork'] == null
          ? null
          : Artwork.fromJson(json['artwork'] as Map<String, dynamic>),
      url: json['url'] as String,
      hlsUrl: json['hlsUrl'] as String?,
    );

Map<String, dynamic> _$PreviewToJson(Preview instance) => <String, dynamic>{
      'artwork': instance.artwork,
      'url': instance.url,
      'hlsUrl': instance.hlsUrl,
    };
