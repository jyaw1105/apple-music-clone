import 'package:apple_music_clone/model/Playlists.dart';
import 'package:apple_music_clone/model/Songs.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:volume_controller/volume_controller.dart';

// class GetSongs extends GetNotifier<Songs?> {
//   GetSongs(super.initial);
// }

// class PlayBinding extends Bindings {
//   @override
//   void dependencies() {
//     // Get.put(Dio());
//     Get.put(PlayController(null));
//   }
// }∏

class PlayControllerModel {
  Songs? song;
  Playlists? playlists;
  double? volume;
  bool isPlaying;
  Duration? duration;
  Duration? currentDuration;
  bool minimizeInfo;
  DisplayOption displayOption;
  List<PlayOption> playOptions;

  PlayControllerModel(
      {this.song,
      this.volume,
      this.isPlaying = false,
      this.duration,
      this.currentDuration,
      this.playlists,
      this.minimizeInfo = false,
      this.displayOption = DisplayOption.none,
      List<PlayOption>? playOptions})
      : playOptions = playOptions ?? [];

  PlayControllerModel copyWith(
      {Songs? song,
      double? volume,
      bool? isPlaying,
      Duration? duration,
      Duration? currentDuration,
      Playlists? playlists,
      bool? minimizeInfo,
      DisplayOption? displayOption,
      List<PlayOption>? playOptions}) {
    return PlayControllerModel(
        song: song ?? this.song,
        volume: volume ?? this.volume,
        isPlaying: isPlaying ?? this.isPlaying,
        duration: duration ?? this.duration,
        currentDuration: currentDuration ?? this.currentDuration,
        playlists: playlists ?? this.playlists,
        minimizeInfo: minimizeInfo ?? this.minimizeInfo,
        displayOption: displayOption ?? this.displayOption,
        playOptions: playOptions ?? this.playOptions);
  }
}

// class PlayController extends GetNotifier<Songs?> {
//   PlayController(super.initial) {
//     change(null, status: RxStatus.success());
//   }

//   void changeSong(Songs song) {
//     change(song, status: RxStatus.success());
//   }
// }

class PlayController extends GetNotifier<PlayControllerModel> {
  final AudioPlayer player = AudioPlayer();
  PlayController(super.initial) {
    change(PlayControllerModel(), status: RxStatus.success());
  }

  void playPlaylist(Playlists playlists) {
    change(
        state!.copyWith(
            song: playlists.relationships!.tracks.data!.first,
            playlists: playlists),
        status: RxStatus.success());
    _playSong(state!.song!);
  }

  void changeSong(Songs song, {Playlists? playlists}) {
    change(state!.copyWith(song: song, playlists: playlists),
        status: RxStatus.success());
    _playSong(song);
  }

  void _playSong(Songs song) {
    if (song.attributes?.previews.first.url != null) {
      player.play(UrlSource(song.attributes!.previews.first.url));
      player.onPlayerComplete.listen((event) {
        Future.delayed(Duration(seconds: 1)).then((value) {
          _onPlayerComplete();
        });
      });
      player.onPlayerStateChanged.listen((PlayerState playerState) {
        bool isPlaying = playerState == PlayerState.playing;
        if (isPlaying != state!.isPlaying) {
          change(state!.copyWith(isPlaying: isPlaying),
              status: RxStatus.success());
        }
      });
      player.onPositionChanged.listen((Duration duration) {
        change(state!.copyWith(currentDuration: duration),
            status: RxStatus.success());
      });
      player.onDurationChanged.listen((Duration duration) {
        change(state!.copyWith(duration: duration), status: RxStatus.success());
      });
      player.onPlayerComplete.listen((event) {
        change(
            state!.copyWith(
                currentDuration: Duration(seconds: 0), isPlaying: false),
            status: RxStatus.success());
      });
    }
  }

  void changeDuration(double value) {
    player.seek(Duration(seconds: value.toInt()));
  }

  void playOnClick() {
    if (state!.isPlaying) {
      _pauseSong();
    } else {
      _resumeSongs();
    }
  }

  void _pauseSong() {
    player.pause();
  }

  void _resumeSongs() {
    player.resume();
  }

  void changeVolume(double volume, {bool updateSystem = false}) {
    if (updateSystem) {
      VolumeController().setVolume(volume);
    }
    change(state!.copyWith(volume: volume), status: RxStatus.success());
  }

  void _onPlayerComplete() {
    List<Songs> songs = state!.playlists!.relationships!.tracks.data!;
    int currentIndex =
        songs.indexWhere((element) => element.id == state!.song!.id);
    if (currentIndex < songs.length - 1) {
      if (state!.playOptions.contains(PlayOption.loopSingle)) {
        changeDuration(0.0);
        player.resume();
      } else {
        nextSong();
      }
    } else if (currentIndex != -1) {
      if (state!.playOptions.contains(PlayOption.loop)) {
        changeSong(songs[0]);
      }
    }
  }

  void nextSong() {
    if (state!.playlists == null) {
      player.pause();
    } else {
      List<Songs> songs = state!.playlists!.relationships!.tracks.data!;
      int currentIndex =
          songs.indexWhere((element) => element.id == state!.song!.id);
      if (currentIndex < 0) {
        changeSong(songs[0]);
      } else if (currentIndex >= songs.length - 1) {
        _onPlayerComplete();
      } else {
        changeSong(songs[currentIndex + 1]);
      }
    }
  }

  void previousSong() {
    if (state!.playlists == null) {
      player.pause();
    } else {
      List<Songs> songs = state!.playlists!.relationships!.tracks.data!;
      int currentIndex =
          songs.indexWhere((element) => element.id == state!.song!.id);
      if (currentIndex <= 0) {
        player.pause();
      } else if (currentIndex >= songs.length - 1) {
        player.pause();
      } else {
        changeSong(songs[currentIndex - 1]);
      }
    }
  }

  @override
  void onInit() {
    super.onInit();
    print('onInit');
    VolumeController().showSystemUI = true;
    VolumeController().listener((volume) {
      changeVolume(volume);
    });
    VolumeController().getVolume().then((volume) {
      changeVolume(volume);
    });
  }

  @override
  void onClose() {
    print("close");
    super.onClose();
  }

  void minimizeInfo(DisplayOption option) {
    if (state!.displayOption == option) {
      change(state!.copyWith(
          minimizeInfo: !state!.minimizeInfo,
          displayOption: DisplayOption.none));
    } else {
      change(state!.copyWith(minimizeInfo: true, displayOption: option));
    }
  }

  void playOptionOnSelected(PlayOption option) {
    List<PlayOption> list = state!.playOptions;
    if (state!.playOptions.contains(option)) {
      list.remove(option);
      if (option == PlayOption.loop) {
        list.add(PlayOption.loopSingle);
      }
    } else {
      list.add(option);
    }
    change(state!.copyWith(playOptions: list));
  }
}

enum DisplayOption { lyrics, list, none }

enum PlayOption { loop, shuffle, loopSingle, auto }
