import 'package:apple_music_clone/model/Playlists.dart';
import 'package:apple_music_clone/util/imageSizeUtil.dart';
import 'package:apple_music_clone/widget/snapping_list_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class GridPlaylistsWidget extends StatelessWidget {
  final List<Playlists> playlists;
  final Function(Playlists) playlistOnTap;
  final int row;
  GridPlaylistsWidget(
      {required this.playlists, required this.playlistOnTap, this.row = 1});

  final double gapPadding = 5.0;

  @override
  Widget build(BuildContext context) {
    double extent = (MediaQuery.of(context).size.width - 30) * 0.5 - 10;
    double width = ((MediaQuery.of(context).size.width - 30) * 0.5) - 10;
    double height = (width + 45.0);

    return SizedBox(
      height: height * row + (gapPadding * row * row),
      child: SnappingListView(
        padding: EdgeInsets.symmetric(horizontal: 20 - gapPadding),
        children: List.generate(
            ((playlists.length - (playlists.length % row)) / row).round() +
                ((playlists.length % row == 0 ? 0 : 1)), (index) {
          List<Playlists> lists =
              playlists.skip(index * row).take(row).toList();
          return Column(
              children: List.generate(lists.length, (j) {
            Playlists e = lists[j];
            return Padding(
              padding: EdgeInsets.only(top: j > 0 ? gapPadding * 3 : 0),
              child: _item(e, width: width, height: height, context: context),
            );
          }));
        }),
        itemExtent: extent,
      ),
    );
  }

  Widget _item(Playlists e,
      {required double width, required height, required BuildContext context}) {
    return Container(
        width: width,
        height: height,
        margin: EdgeInsets.symmetric(horizontal: gapPadding),
        child: GestureDetector(
          onTap: () => playlistOnTap(e),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  width: width - gapPadding - gapPadding,
                  height: width - gapPadding - gapPadding,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                        image: CachedNetworkImageProvider(
                            ImageSizeUtil.parse(e.attributes.artwork.url)),
                        fit: BoxFit.cover),
                  )),
              Padding(
                  padding: const EdgeInsets.only(top: 7.0, bottom: 3.0),
                  child: Text(
                    e.attributes.name,
                    style: TextStyle(fontSize: 16, color: Colors.white),
                    maxLines: 1,
                  )),
              Text(
                e.attributes.curatorName,
                style:
                    TextStyle(fontSize: 16, color: Theme.of(context).hintColor),
                maxLines: 1,
              ),
            ],
          ),
        ));
  }
}
