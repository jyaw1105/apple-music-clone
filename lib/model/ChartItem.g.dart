// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ChartItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChartItem<T> _$ChartItemFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    ChartItem<T>(
      name: json['name'] as String,
      data: (json['data'] as List<dynamic>).map(fromJsonT).toList(),
    );

Map<String, dynamic> _$ChartItemToJson<T>(
  ChartItem<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'name': instance.name,
      'data': instance.data.map(toJsonT).toList(),
    };
