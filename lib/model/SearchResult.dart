import 'package:apple_music_clone/model/Albums/Albums.dart';
import 'package:apple_music_clone/model/Playlists.dart';
import 'package:apple_music_clone/model/Songs.dart';

class SearchParam<T> {
  final String? href;
  final String? next;
  final List data;

  SearchParam({required this.href, this.next, required this.data});
  factory SearchParam.fromJson(
      Map<String, dynamic> jsonMap, T Function(Object? json) fromJsonT) {
    return SearchParam(
        href: jsonMap['href'],
        next: jsonMap['next'],
        data: (jsonMap['data'] as List<dynamic>).map(fromJsonT).toList());
  }

  factory SearchParam.fromJsonMixed(Map<String, dynamic> jsonMap) {
    List<dynamic> data = (jsonMap['data'] as List<dynamic>);
    List<dynamic> lists = data.map((e) {
      String? type = e['type'];
      switch (type) {
        case 'albums':
          return Albums.fromJson(e);
        case 'playlists':
          return Playlists.fromJson(e);
        case 'songs':
          return Songs.fromJson(e);
        default:
          return null;
      }
    }).toList();
    lists.removeWhere((element) => element == null);
    return SearchParam(
        href: jsonMap['href'], next: jsonMap['next'], data: lists);
  }
}
