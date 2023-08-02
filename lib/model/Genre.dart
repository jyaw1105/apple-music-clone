import 'package:json_annotation/json_annotation.dart';

part 'Genre.g.dart';

@JsonSerializable()
class Genre {
  final String id;
  final String href;
  final GenreAttribute attributes;
  Genre({required this.id, required this.href, required this.attributes});

  @override
  factory Genre.fromJson(Map<String, dynamic> json) => _$GenreFromJson(json);
}

@JsonSerializable()
class GenreAttribute {
  final String? parentName;
  final String name;
  final String? parentId;

  GenreAttribute({this.parentName, required this.name, this.parentId});

  @override
  factory GenreAttribute.fromJson(Map<String, dynamic> json) =>
      _$GenreAttributeFromJson(json);
}
