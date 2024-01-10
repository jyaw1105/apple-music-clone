library play_page;

import 'dart:math';

import 'package:apple_music_clone/model/Songs.dart';
import 'package:apple_music_clone/provider/theme.dart';
import 'package:apple_music_clone/service/appleMusic/PlayService.dart';
import 'package:apple_music_clone/src/Chart/View/SongTile.dart';
import 'package:apple_music_clone/util/imageSizeUtil.dart';
import 'package:apple_music_clone/widget/app_icon_class_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

part './src/control.dart';
part './src/duration.dart';
part './src/image.dart';
part './src/playSmall.dart';
part './src/volume.dart';
part 'src/List.dart';
part 'src/option_button.dart';
part 'src/song_info.dart';

class PlayPage extends GetView<PlayController> {
  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (PlayControllerModel? model) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 35.0, vertical: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            gradient: LinearGradient(
                colors: [ThemeHelper.color1, ThemeHelper.color2],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.3, 0.7])),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                width: 45.0,
                height: 6.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: ThemeHelper.handlerColor),
              ),
              SizedBox(height: 15.0),
              _SongInfo(
                  song: model?.song, isHeader: model?.minimizeInfo ?? false),
              SizedBox(height: 30.0),
              Expanded(
                child: Column(
                  children: [
                    AnimatedOpacity(
                      opacity: model!.minimizeInfo ? 0.0 : 1.0,
                      duration: Duration(milliseconds: 200),
                      child: _DurationBar(
                        duration: model.duration,
                        currentDuration: model.currentDuration,
                        onChanged: (double volume) async {
                          controller.changeDuration(volume);
                        },
                      ),
                    ),
                    Expanded(child: LayoutBuilder(
                      builder: (context, constraints) {
                        return AnimatedContainer(
                          height:
                              model!.minimizeInfo ? constraints.maxHeight : 0.0,
                          duration: Duration(milliseconds: 200),
                          child: model.minimizeInfo
                              ? model.displayOption == DisplayOption.list
                                  ? _List(currentOption: model.playOptions)
                                  : Container()
                              : null,
                        );
                      },
                    )),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 25),
                      child: _ControlButton(
                        playOnPressed: () {
                          controller.playOnClick();
                        },
                        nextOnPressed: () {
                          controller.nextSong();
                        },
                        backOnPressed: () {
                          controller.previousSong();
                        },
                        isPlaying: model!.isPlaying,
                      ),
                    ),
                    SizedBox(height: 10),
                    _Volume(
                      onChanged: (double volume) async {
                        controller.changeVolume(volume, updateSystem: true);
                      },
                      value: model.volume ?? 1.0,
                    ),
                    SizedBox(height: 30.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _DisplayOptionButton(
                          value: DisplayOption.lyrics,
                          current: model.displayOption,
                          icon: (model.song?.attributes?.hasLyrics ?? false)
                              ? AppIconClass.lyrics
                              : AppIconClass.lyrics_filled,
                          enabled: (model.song?.attributes?.hasLyrics ?? false),
                          onTap: (DisplayOption option) {
                            controller.minimizeInfo(option);
                          },
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.airplay_outlined,
                              size: 30,
                            )),
                        _DisplayOptionButton(
                          value: DisplayOption.list,
                          current: model.displayOption,
                          icon: Icons.list_rounded,
                          onTap: (DisplayOption option) {
                            controller.minimizeInfo(option);
                          },
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
