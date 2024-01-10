import 'package:apple_music_clone/model/Albums/Albums.dart';
import 'package:apple_music_clone/model/Playlists.dart';
import 'package:apple_music_clone/model/SearchResult.dart';
import 'package:apple_music_clone/model/Songs.dart';
import 'package:apple_music_clone/service/appleMusic/PlayService.dart';
import 'package:apple_music_clone/src/Chart/View/AlbumTile.dart';
import 'package:apple_music_clone/src/Chart/View/PlaylistTile.dart';
import 'package:apple_music_clone/src/Chart/View/SongTile.dart';
import 'package:apple_music_clone/src/Chart/View/SongTileExpanded.dart';
import 'package:apple_music_clone/src/Search/controller/search_result_controller.dart';
import 'package:apple_music_clone/widget/rectangular_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class SearchResultWidget extends StatelessWidget {
  final Map<String, SearchParam<dynamic>>? data;

  SearchResultWidget({required this.data}) {
    controller = Get.put(SearchResultController(data));
  }

//   @override
//   State<StatefulWidget> createState() => _SearchResultWidgetState();
// }

// class _SearchResultWidgetState extends State<SearchResultWidget> {

  late SearchResultController controller;

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

  // final SearchResultBloc bloc = SearchResultBloc();

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
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
                      onTap: controller.tabOnTap,
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
                      dividerHeight: 0.0,
                      tabAlignment: TabAlignment.start,
                      tabs: (data?.keys ?? {})
                          .toList()
                          .map((e) => Tab(
                                text: parseTitle(e),
                              ))
                          .toList()),
                )),
            Expanded(child: Obx(() {
              int? currentPage = controller.currentPageRx.value;
              return IndexedStack(
                index: currentPage,
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
                              builder: (context, Animation<double> animation) {
                                bool showBig = !animation.isDismissed &&
                                    animation.isCompleted;
                                Widget child = Container();
                                if (item is Songs) {
                                  if (showBig) {
                                    child = SongTileExpanded(song: item);
                                  }
                                  child = SongTile(
                                    song: item,
                                    onTap: () {
                                      Get.find<PlayController>()
                                          .changeSong(item);
                                    },
                                  );
                                } else if (item is Playlists) {
                                  child = PlaylistTile(playlists: item);
                                } else if (item is Albums) {
                                  child = AlbumTile(albums: item);
                                }
                                return InkWell(
                                  child: child,
                                  onTap: () {
                                    controller.itemOnTap(item);
                                  },
                                );
                              });
                        }).toList(),
                      ),
                    )
                    .toList(),
              );
            }))
          ],
        ),
      );
    });
  }
}
