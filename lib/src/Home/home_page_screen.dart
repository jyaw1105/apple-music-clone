import 'package:apple_music_clone/core/app_export.dart';
import 'package:apple_music_clone/src/Browse/View/Browse.dart';
import 'package:apple_music_clone/src/Home/controller/home_page_controller.dart';
import 'package:apple_music_clone/src/Home/widget/ComingSoon.dart';
import 'package:apple_music_clone/src/Play/play_page_screen.dart';
import 'package:apple_music_clone/src/Search/search_page_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends GetWidget<HomePageController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        List<Widget> children = !controller.hasConnectivity.value
            ? List.generate(
                3, (index) => Center(child: Text("No Connectivity")))
            : [
                BrowsePage(),
                ComingSoonPage(),
                SearchPage(),
              ];
        return Scaffold(
          body: IndexedStack(
            children: children
                .asMap()
                .map(
                  (int index, e) => MapEntry(
                    index,
                    Navigator(
                      key: controller.navigatorKeys[index],
                      onGenerateRoute: (RouteSettings settings) {
                        return MaterialPageRoute(
                          settings: settings,
                          builder: (BuildContext context) {
                            return e;
                          },
                        );
                      },
                    ),
                  ),
                )
                .values
                .toList(),
            index: controller.pageIndex.value,
          ),
          bottomSheet: BottomSheet(
              animationController: controller.animationController,
              showDragHandle: false,
              enableDrag: true,
              onDragStart: (DragStartDetails _) {},
              onDragEnd: (details, {bool isClosing = false}) {
                if (isClosing) {
                } else {
                  Get.bottomSheet(PlayPage(),
                      isScrollControlled: true,
                      ignoreSafeArea: false,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(20))));
                }
              },
              onClosing: () {},
              builder: (_) {
                return PlaySmall();
              }),
          bottomNavigationBar: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CupertinoTabBar(
                currentIndex: controller.pageIndex.value,
                onTap: controller.tabOnTap,
                items: [
                  // BottomNavigationBarItem(
                  //   icon: Icon(Icons.play_circle_fill_rounded),
                  //   label: "Listen Now",
                  // ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.grid_view_rounded),
                    label: "Browse",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.my_library_music_rounded),
                    label: "Library",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.search_rounded),
                    label: "Search",
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
