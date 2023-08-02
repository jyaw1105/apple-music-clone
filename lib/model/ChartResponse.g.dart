// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ChartResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChartResponse _$ChartResponseFromJson(Map<String, dynamic> json) =>
    ChartResponse(
      songs: (json['songs'] as List<dynamic>?)
          ?.map((e) => ChartItem<Songs>.fromJson(e as Map<String, dynamic>,
              (value) => Songs.fromJson(value as Map<String, dynamic>)))
          .toList(),
      cityCharts: (json['cityCharts'] as List<dynamic>?)
          ?.map((e) => ChartItem<Playlists>.fromJson(e as Map<String, dynamic>,
              (value) => Playlists.fromJson(value as Map<String, dynamic>)))
          .toList(),
      dailyGlobalTopCharts: (json['dailyGlobalTopCharts'] as List<dynamic>?)
          ?.map((e) => ChartItem<Playlists>.fromJson(e as Map<String, dynamic>,
              (value) => Playlists.fromJson(value as Map<String, dynamic>)))
          .toList(),
      playlists: (json['playlists'] as List<dynamic>?)
          ?.map((e) => ChartItem<Playlists>.fromJson(e as Map<String, dynamic>,
              (value) => Playlists.fromJson(value as Map<String, dynamic>)))
          .toList(),
      albums: (json['albums'] as List<dynamic>?)
          ?.map((e) => ChartItem<Albums>.fromJson(e as Map<String, dynamic>,
              (value) => Albums.fromJson(value as Map<String, dynamic>)))
          .toList(),
    );

Map<String, dynamic> _$ChartResponseToJson(ChartResponse instance) =>
    <String, dynamic>{
      'songs': instance.songs,
      'cityCharts': instance.cityCharts,
      'dailyGlobalTopCharts': instance.dailyGlobalTopCharts,
      'playlists': instance.playlists,
      'albums': instance.albums,
    };
