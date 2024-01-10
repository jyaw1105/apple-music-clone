// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Artwork.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Artwork _$ArtworkFromJson(Map<String, dynamic> json) => Artwork(
      bgColor: json['bgColor'] as String?,
      height: (json['height'] as num).toDouble(),
      width: (json['width'] as num).toDouble(),
      textColor1: json['textColor1'] as String?,
      textColor2: json['textColor2'] as String?,
      textColor3: json['textColor3'] as String?,
      textColor4: json['textColor4'] as String?,
      url: json['url'] as String,
    );

Map<String, dynamic> _$ArtworkToJson(Artwork instance) => <String, dynamic>{
      'bgColor': instance.bgColor,
      'height': instance.height,
      'width': instance.width,
      'textColor1': instance.textColor1,
      'textColor2': instance.textColor2,
      'textColor3': instance.textColor3,
      'textColor4': instance.textColor4,
      'url': instance.url,
    };
