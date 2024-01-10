import 'package:apple_music_clone/core/app_export.dart';
import 'package:apple_music_clone/model/Genre.dart';
import 'package:apple_music_clone/model/SearchResult.dart';
import 'package:apple_music_clone/src/Search/controller/search_page_controller.dart';
import 'package:apple_music_clone/src/Search/model/search_model.dart';
import 'package:apple_music_clone/src/Search/widget/SeachResultWidget.dart';
import 'package:apple_music_clone/src/Search/widget/TransitionAppBar.dart';
import 'package:apple_music_clone/widget/keep_alive_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:responsive_grid/responsive_grid.dart';

class SearchPage extends GetView<SearchPageController> {
  final ValueNotifier<bool> showAppBar = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return KeepAliveWrapper(
      child: Scaffold(
          body: SafeArea(
        child: NotificationListener(
          onNotification: (ScrollNotification scrollInfo) {
            if (scrollInfo.metrics.axis == Axis.vertical) {
              showAppBar.value = scrollInfo.metrics.pixels >= kToolbarHeight;
              return true;
            }
            return false;
          },
          child: Obx(() {
            SearchStatus searchStatus =
                controller.searchModelRx.value.searchStatusRx.value;
            Map<String, SearchParam<dynamic>>? searchResults =
                controller.searchModelRx.value.searchResults.value;
            List<Genre>? genres = controller.searchModelRx.value.genres.value;
            return Scrollbar(
              child: CustomScrollView(
                slivers: [
                  TransitionAppBar(
                    searchController:
                        controller.searchModelRx.value.searchController,
                    searchOnSubmitted: controller.searchOnSubmitted,
                    searchFocusNode:
                        controller.searchModelRx.value.searchFocusNode,
                    cancelOnTap: controller.cancelOnTap,
                  ),

                  // SliverList(
                  //     delegate: SliverChildListDelegate([

                  // ])),
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: searchStatus == SearchStatus.searching
                        ? Text("Searching")
                        : searchStatus == SearchStatus.result
                            ? SearchResultWidget()
                            : ((genres ?? []).isNotEmpty)
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ResponsiveGridRow(
                                      children: genres!
                                          .map((Genre genre) =>
                                              ResponsiveGridCol(
                                                  xs: 6,
                                                  md: 6,
                                                  lg: 4,
                                                  child: Container(
                                                    height: 80,
                                                    width: double.infinity,
                                                    decoration: BoxDecoration(
                                                        color: Colors.red,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0)),
                                                    margin: EdgeInsets.all(5.0),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(genre
                                                            .attributes.name)
                                                      ],
                                                    ),
                                                  )))
                                          .toList(),
                                    ),
                                  )
                                : Container(),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 95.0),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      )),
    );
  }
}
