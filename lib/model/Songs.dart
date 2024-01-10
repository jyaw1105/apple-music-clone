import 'package:apple_music_clone/model/SongsAttributes.dart';
import 'package:json_annotation/json_annotation.dart';

import 'ChartItem.dart';

part 'Songs.g.dart';

@JsonSerializable()
class Songs {
  final String id;
  final String type;
  final String href;
  final SongsAttributes? attributes;
  // final relationships;

  Songs({
    required this.id,
    required this.type,
    required this.href,
    this.attributes,
  });

  @override
  factory Songs.fromJson(Map<String, dynamic> json) => _$SongsFromJson(json);
}
