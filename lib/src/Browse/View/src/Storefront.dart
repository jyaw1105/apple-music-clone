import 'package:apple_music_clone/model/Playlists.dart';
import 'package:apple_music_clone/util/imageSizeUtil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class StorefrontWidget extends StatelessWidget {
  final List<Playlists> playlists;
  final void Function(Playlists) playlistOnTap;
  StorefrontWidget({required this.playlists, required this.playlistOnTap});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
          enableInfiniteScroll: false,
          height: MediaQuery.of(context).size.width * 0.75,
          viewportFraction: 0.9),
      items: playlists
          .map((Playlists e) => Container(
              margin: EdgeInsets.symmetric(horizontal: 5),
              child: GestureDetector(
                onTap: () => playlistOnTap(e),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(bottom: 5.0),
                        child: Text(
                          e.attributes.name,
                          style: TextStyle(fontSize: 22, color: Colors.white),
                          maxLines: 1,
                        )),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: Text(
                        e.attributes.curatorName,
                        style: TextStyle(
                            fontSize: 20, color: Theme.of(context).hintColor),
                        maxLines: 1,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                  ImageSizeUtil.parse(
                                e.attributes.artwork.url,
                              )),
                              fit: BoxFit.fitHeight),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 10),
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              e.attributes.description?.short ?? "",
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )))
          .toList(),
    );
  }
}
