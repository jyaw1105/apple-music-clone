import 'package:apple_music_clone/model/Playlists.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';

class DescriptionModal extends StatelessWidget {
  final Playlists playlists;
  DescriptionModal({required this.playlists});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DraggableScrollableSheet(
          initialChildSize: 1.0,
          maxChildSize: 1.0,
          minChildSize: 1.0,
          expand: true,
          builder: (context, scrollController) {
            return Material(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              color: Colors.black87,
              child: Container(
                height: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).viewPadding.top,
                padding: EdgeInsets.symmetric(vertical: 25, horizontal: 25),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    AppBar(
                      leading: Container(),
                      backgroundColor: Colors.transparent,
                      title: Text(playlists.attributes.name),
                      actions: [
                        TextButton(
                            onPressed: () {
                              if (Get.isBottomSheetOpen ?? false) {
                                Get.back();
                              }
                            },
                            child: Text(
                              "Done",
                              style: TextStyle(color: Colors.red, fontSize: 14),
                            ))
                      ],
                    ),
                    HtmlWidget(
                      playlists.attributes.description!.standard,
                      textStyle: TextStyle(
                          color: Colors.white, height: 1.5, fontSize: 16),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
