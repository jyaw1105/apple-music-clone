import 'package:apple_music_clone/model/Songs.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../util/imageSizeUtil.dart';

class SongTile extends StatelessWidget {
  final double padding = 5.0;
  final double margin = 0.0;
  final int maxLines = 1;
  final Color bgcolor = Colors.transparent;
  final double borderRadius = 8.0;
  final double imageSize = 55.0;
  final Songs song;
  SongTile({required this.song});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
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
            child: Container(
              margin: EdgeInsets.only(right: 15),
              constraints: BoxConstraints(minHeight: imageSize + 10),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          color: Theme.of(context).disabledColor, width: 0.4))),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      // mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10.0),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Flexible(
                                child: Text(song.attributes?.name ?? "",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        height: 1.4),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: maxLines)),
                            if (song.attributes?.isAppleDigitalMaster ?? false)
                              Container(
                                margin: EdgeInsets.only(left: 5.0),
                                width: 15,
                                height: 15,
                                decoration: BoxDecoration(
                                    color: Theme.of(context).hintColor,
                                    borderRadius: BorderRadius.circular(4.0)),
                                child: Center(
                                  child: Text("E",
                                      style: TextStyle(
                                          fontSize: 9.0, color: Colors.black)),
                                ),
                              )
                          ],
                        ),
                        SizedBox(height: 2.0),
                        Text(
                          song.attributes?.artistName ?? "",
                          style: TextStyle(
                              fontSize: 13, color: Theme.of(context).hintColor),
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10),
                  PopupMenuButton(
                      tooltip: '',
                      offset: Offset(0, imageSize - 5),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      itemBuilder: (context) => [
                            PopupMenuItem(
                              height: 30,
                              padding: EdgeInsets.only(left: 15),
                              child: Container(
                                width: MediaQuery.of(context).size.width / 2.5,
                                child: Row(
                                  children: [
                                    Expanded(child: Text("Share")),
                                    Icon(Icons.share)
                                  ],
                                ),
                              ),
                            )
                          ],
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.more_horiz_rounded,
                          color: Theme.of(context).hintColor,
                          size: 24.0,
                        ),
                      ))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
