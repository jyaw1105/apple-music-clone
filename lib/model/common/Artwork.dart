import 'package:json_annotation/json_annotation.dart';

part 'Artwork.g.dart';

@JsonSerializable()
class Artwork {
  final String? bgColor;
  final double height;
  final double width;
  final String? textColor1;
  final String? textColor2;
  final String? textColor3;
  final String? textColor4;
  final String url;

  Artwork(
      {this.bgColor,
      required this.height,
      required this.width,
      this.textColor1,
      this.textColor2,
      this.textColor3,
      this.textColor4,
      required this.url});

  factory Artwork.fromJson(Map<String, dynamic> json) =>
      _$ArtworkFromJson(json);
}
