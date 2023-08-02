import 'package:apple_music_clone/model/Albums/Albums.dart';
import 'package:apple_music_clone/model/Playlists.dart';
import 'package:apple_music_clone/model/SearchResult.dart';
import 'package:apple_music_clone/model/Songs.dart';
import 'package:apple_music_clone/src/Chart/View/AlbumTile.dart';
import 'package:apple_music_clone/src/Chart/View/PlaylistTile.dart';
import 'package:apple_music_clone/src/Chart/View/SongTile.dart';
import 'package:apple_music_clone/src/Chart/View/SongTileExpanded.dart';
import 'package:apple_music_clone/src/SearchResult/Bloc/bloc.dart';
import 'package:apple_music_clone/src/SearchResult/Bloc/event.dart';
import 'package:apple_music_clone/src/SearchResult/Bloc/state.dart';
import 'package:apple_music_clone/widget/rectangular_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchResultWidget extends StatefulWidget {
  final Map<String, SearchParam<dynamic>>? data;

  SearchResultWidget({required this.data});

  @override
  State<StatefulWidget> createState() => _SearchResultWidgetState();
}

class _SearchResultWidgetState extends State<SearchResultWidget> {
  Map<String, SearchParam<dynamic>>? get data => widget.data;

  String parseTitle(String e) {
    if (e == 'topResults') {
      return 'Top Results';
    } else if (e == 'songs') {
      return "Songs";
    } else if (e == 'albums') {
      return "Albums";
    } else if (e == "playlists") {
      return "Playlists";
    }
    return e;
  }

  final SearchResultBloc bloc = SearchResultBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchResultBloc>(
        create: (_) => bloc,
        child: BlocListener<SearchResultBloc, SearchResultState>(
            listener: (context, state) {
          // if (state is HomeInitFailed) {
          //   SmartDialog.showToast(state.message);
          // }
        }, child: BlocBuilder<SearchResultBloc, SearchResultState>(
                builder: (context, SearchResultState state) {
          if ((data?.keys ?? {}).isEmpty) {
            return Center(
              child: Text("No Result"),
            );
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              children: [
                DefaultTabController(
                    length: data!.keys.length,
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(bottom: 10),
                      margin: EdgeInsets.only(bottom: 5),
                      height: 40,
                      child: TabBar(
                          onTap: (int index) {
                            bloc.add(SearchResultTabOnChangeEvent(page: index));
                          },
                          splashBorderRadius: BorderRadius.circular(30),
                          indicator: RectangularIndicator(
                            color: Colors.red,
                            bottomLeftRadius: 30,
                            bottomRightRadius: 30,
                            topRightRadius: 30,
                            topLeftRadius: 30,
                          ),
                          isScrollable: true,
                          indicatorSize: TabBarIndicatorSize.tab,
                          labelStyle: TextStyle(fontWeight: FontWeight.w600),
                          tabs: (data?.keys ?? {})
                              .toList()
                              .map((e) => Tab(
                                    text: parseTitle(e),
                                  ))
                              .toList()),
                    )),
                Expanded(
                    child: IndexedStack(
                  index: state.currentPage,
                  children: data!.keys
                      .map(
                        (e) => Column(
                          children: (data![e]!.data).map<Widget>((item) {
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
                                  Widget child = Container();
                                  if (item is Songs) {
                                    if (showBig) {
                                      child = SongTileExpanded(song: item);
                                    }
                                    child = SongTile(song: item);
                                  } else if (item is Playlists) {
                                    child = PlaylistTile(playlists: item);
                                  } else if (item is Albums) {
                                    child = AlbumTile(albums: item);
                                  }
                                  return InkWell(
                                    child: child,
                                    onTap: () {
                                      bloc.add(
                                          SearchResultOnTapEvent(data: item));
                                    },
                                  );
                                });
                          }).toList(),
                        ),
                      )
                      .toList(),
                ))
              ],
            ),
          );
        })));
  }
}
