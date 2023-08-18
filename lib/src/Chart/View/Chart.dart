import 'package:apple_music_clone/model/Playlists.dart';
import 'package:apple_music_clone/model/Songs.dart';
import 'package:apple_music_clone/service/appleMusic/PlayService.dart';
import 'package:apple_music_clone/src/Chart/Bloc/bloc.dart';
import 'package:apple_music_clone/src/Chart/Bloc/event.dart';
import 'package:apple_music_clone/src/Chart/Bloc/state.dart';
import 'package:apple_music_clone/src/Chart/View/SongTile.dart';
import 'package:apple_music_clone/src/Chart/View/SongTileExpanded.dart';
import 'package:apple_music_clone/util/imageSizeUtil.dart';
import 'package:apple_music_clone/widget/hex_color.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class ChartPage extends StatefulWidget {
  final Playlists? playlists;
  final String? href;

  ChartPage({required this.playlists, required this.href});
  @override
  State<StatefulWidget> createState() =>
      _ChartPageState(playlists: playlists, href: href);
}

class _ChartPageState extends State<ChartPage> {
  final Playlists? playlists; // = Get.arguments['playlists'];
  final String? href; // = Get.arguments['href'];

  _ChartPageState({required this.playlists, required this.href});

  final ChartBloc bloc = ChartBloc();
  ValueNotifier<bool> showAppBar = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    bloc.add(GetDataByType(playlists: playlists, href: href));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChartBloc>(
        create: (_) => bloc,
        child: BlocListener<ChartBloc, ChartState>(listener: (context, state) {
          if (state.errorMessage != null) {
            SmartDialog.showToast(state.errorMessage!);
          }
        }, child: BlocBuilder<ChartBloc, ChartState>(
            builder: (context, ChartState state) {
          Playlists? playlists = state.playlists;

          return Scaffold(
            body: NotificationListener(
              onNotification: (ScrollNotification scrollInfo) {
                if (scrollInfo.metrics.axis == Axis.vertical) {
                  showAppBar.value = scrollInfo.metrics.pixels >=
                      (0 + MediaQuery.of(context).size.height * 0.55);
                  return true;
                }
                return false;
              },
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    expandedHeight: kToolbarHeight +
                        MediaQuery.of(context).size.height * 0.55,
                    title: ValueListenableBuilder(
                        valueListenable: showAppBar,
                        builder: (context, bool value, __) {
                          return AnimatedOpacity(
                            opacity: value ? 1.0 : 0.0,
                            duration: Duration(milliseconds: 300),
                            child: Stack(
                              children: [
                                // Positioned.fill(
                                //   child: BackdropFilter(
                                //     filter: ImageFilter.blur(
                                //         sigmaX: 10.0, sigmaY: 10.0),
                                //     child: Container(
                                //       height: double.infinity,
                                //     ),
                                //   ),
                                // ),
                                Text(
                                  playlists?.attributes.name ?? state.title,
                                ),
                              ],
                            ),
                          );
                        }),
                    floating: false,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                      collapseMode: CollapseMode.pin,
                      stretchModes: playlists?.attributes.artwork.width ==
                              playlists?.attributes.artwork.height
                          ? []
                          : [StretchMode.zoomBackground],
                      background: Container(
                        // height: 150,
                        width: playlists?.attributes.artwork.width ==
                                playlists?.attributes.artwork.height
                            ? 150
                            : null,
                        decoration: playlists == null
                            ? null
                            : BoxDecoration(
                                image: DecorationImage(
                                    image: CachedNetworkImageProvider(
                                      ImageSizeUtil.parse(
                                        playlists.attributes.artwork.url,
                                        width:
                                            playlists.attributes.artwork.width,
                                        height:
                                            playlists.attributes.artwork.height,
                                      ),
                                    ),
                                    fit: BoxFit.fitHeight),
                              ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              playlists?.attributes.name ?? state.title,
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                            SizedBox(height: 5),
                            Text(
                              playlists?.attributes.curatorName ?? "",
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                            SizedBox(height: 15),
                            // Text(playlists?.attributes.lastModifiedDate ?? "" , style: TextStyle(color: Colors.white),)
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Expanded(
                                      child: TextButton(
                                    onPressed: () {
                                      Get.find<PlayController>()
                                          .playPlaylist(playlists!);
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(FontAwesomeIcons.play,
                                            size: 18,
                                            color: HexColor.fromHex(playlists
                                                    ?.attributes
                                                    .artwork
                                                    .bgColor ??
                                                '000000')),
                                        SizedBox(width: 5.0),
                                        Text(
                                          "Play",
                                          style: TextStyle(
                                              fontSize: 17,
                                              color: HexColor.fromHex(playlists
                                                      ?.attributes
                                                      .artwork
                                                      .bgColor ??
                                                  '000000')),
                                        )
                                      ],
                                    ),
                                    style: ButtonStyle(
                                        minimumSize: MaterialStatePropertyAll(
                                            Size.fromHeight(45)),
                                        shape: MaterialStatePropertyAll(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8))),
                                        backgroundColor:
                                            MaterialStatePropertyAll(
                                                (HexColor.fromHex(playlists
                                                            ?.attributes
                                                            .artwork
                                                            .textColor4 ??
                                                        '99FFFFFF'))
                                                    .withOpacity(0.9))),
                                  )),
                                  SizedBox(
                                    width: 25,
                                  ),
                                  Expanded(
                                      child: TextButton(
                                    onPressed: () {},
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(FontAwesomeIcons.shuffle,
                                            size: 18,
                                            color: HexColor.fromHex(playlists
                                                    ?.attributes
                                                    .artwork
                                                    .bgColor ??
                                                '000000')),
                                        SizedBox(width: 5.0),
                                        Text(
                                          "Shuffle",
                                          style: TextStyle(
                                              fontSize: 17,
                                              color: HexColor.fromHex(playlists
                                                      ?.attributes
                                                      .artwork
                                                      .bgColor ??
                                                  '000000')),
                                        )
                                      ],
                                    ),
                                    style: ButtonStyle(
                                        minimumSize: MaterialStatePropertyAll(
                                            Size.fromHeight(45)),
                                        shape: MaterialStatePropertyAll(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8))),
                                        backgroundColor:
                                            MaterialStatePropertyAll(
                                                (HexColor.fromHex(playlists
                                                            ?.attributes
                                                            .artwork
                                                            .textColor4 ??
                                                        '99FFFFFF'))
                                                    .withOpacity(0.9))),
                                  )),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            if ((state.playlists?.attributes.description
                                        ?.standard ??
                                    '')
                                .isNotEmpty)
                              GestureDetector(
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 25),
                                  height: 35,
                                  child: Stack(
                                    children: [
                                      HtmlWidget(
                                        state.playlists?.attributes.description
                                                ?.standard ??
                                            '',
                                        textStyle: TextStyle(
                                            overflow: TextOverflow.fade,
                                            fontSize: 15),
                                      ),
                                      Positioned(
                                          bottom: -1,
                                          right: 0,
                                          child: Text(
                                            "MORE",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ))
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  bloc.add(DescriptionOnTap());
                                },
                              ),
                            SizedBox(height: 20)
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (state.playlists != null)
                    SliverPadding(
                      padding: const EdgeInsets.fromLTRB(15.0, 10, 0, 10),
                      sliver: SliverList.builder(
                          itemCount:
                              (state.playlists!.relationships?.tracks.data ??
                                      [])
                                  .length,
                          itemBuilder: (context, int index) {
                            Songs song = state
                                .playlists!.relationships!.tracks.data![index];
                            return CupertinoContextMenu.builder(
                                actions: [
                                  CupertinoContextMenuAction(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    trailingIcon: CupertinoIcons.share,
                                    child: const Text("Share"),
                                  )
                                ],
                                builder:
                                    (context, Animation<double> animation) {
                                  bool showBig = !animation.isDismissed &&
                                      animation.isCompleted;
                                  if (showBig) {
                                    return SongTileExpanded(song: song);
                                  }
                                  return SongTile(
                                    song: song,
                                    onTap: () {
                                      Get.find<PlayController>().changeSong(
                                          song,
                                          playlists: playlists);
                                    },
                                  );
                                });
                          }),
                    )
                ],
              ),
            ),
          );
        })));
  }
}
