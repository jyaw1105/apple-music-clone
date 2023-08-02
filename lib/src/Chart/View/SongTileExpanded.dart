import 'package:apple_music_clone/model/Songs.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../util/imageSizeUtil.dart';

class SongTileExpanded extends StatelessWidget {
  final double padding = 20.0;
  final double margin = 10.0;
  final int maxLines = 2;
  final Color bgcolor = Color(0xff2c2c2c);
  final double borderRadius = 12.0;
  final double imageSize = 100.0;
  final Songs song;
  SongTileExpanded({required this.song});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      decoration: BoxDecoration(
          color: bgcolor, borderRadius: BorderRadius.circular(borderRadius)),
      margin: EdgeInsets.all(margin),
      duration: Duration(milliseconds: 400),
      padding: EdgeInsets.all(padding),
      child: IntrinsicHeight(
        child: Row(children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius),
            child: Container(
                width: imageSize,
                height: imageSize,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(borderRadius)),
                child: song.attributes?.artwork.url != null
                    ? CachedNetworkImage(
                        imageUrl: ImageSizeUtil.parse(
                            song.attributes!.artwork.url,
                            webp: false),
                        fit: BoxFit.cover,
                      )
                    : null),
          ),
          SizedBox(width: 20),
          Expanded(
            child: Column(
              // mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8.0),
                Text(song.attributes?.name ?? "",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        height: 1.4),
                    overflow: TextOverflow.ellipsis,
                    maxLines: maxLines),
                SizedBox(height: 2.0),
                Text(
                  song.attributes?.artistName ?? "",
                  style: TextStyle(
                      fontSize: 13, color: Theme.of(context).hintColor),
                  maxLines: 1,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 2.0),
                  child: Text(song.attributes?.albumName ?? "",
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).disabledColor,
                      ),
                      maxLines: maxLines),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
