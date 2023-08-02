import 'package:json_annotation/json_annotation.dart';

part 'DescriptionAttribute.g.dart';

@JsonSerializable()
class DescriptionAttribute {
  final String? short;
  final String standard;
  DescriptionAttribute({this.short, required this.standard});

  factory DescriptionAttribute.fromJson(Map<String, dynamic> json) =>
      _$DescriptionAttributeFromJson(json);
}
