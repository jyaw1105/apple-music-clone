import 'package:apple_music_clone/model/Albums/AlbumsAttributes.dart';
import 'package:json_annotation/json_annotation.dart';

part 'Albums.g.dart';

@JsonSerializable()
class Albums {
  final String id;
  final String type;
  final String href;
  final AlbumsAttributes? attributes;
  // final AlbumsRelationships relationships;

  Albums(
      {required this.id,
      required this.type,
      required this.href,
      this.attributes});

  factory Albums.fromJson(Map<String, dynamic> json) => _$AlbumsFromJson(json);
}
