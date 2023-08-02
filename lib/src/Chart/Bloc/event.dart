import 'package:apple_music_clone/model/Playlists.dart';
import 'package:apple_music_clone/model/Songs.dart';

abstract class ChartEvent {}

class GetTop100 extends ChartEvent {
  GetTop100();
}

class GetDataByType extends ChartEvent {
  final Playlists? playlists;
  final String? href;
  GetDataByType({this.playlists, this.href});
}

class GetDataByHref extends ChartEvent {
  final String href;
  GetDataByHref({required this.href});
}

class DescriptionOnTap extends ChartEvent {}

class MoreOnTap extends ChartEvent {
  final Songs song;
  MoreOnTap({required this.song});
}
