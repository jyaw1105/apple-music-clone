import 'package:apple_music_clone/model/common/Artwork.dart';
import 'package:json_annotation/json_annotation.dart';

part 'Preview.g.dart';

@JsonSerializable()
class Preview {
  final Artwork? artwork;
  final String url;
  final String? hlsUrl;
  Preview({this.artwork, required this.url, this.hlsUrl});

  factory Preview.fromJson(Map<String, dynamic> json) =>
      _$PreviewFromJson(json);
}
