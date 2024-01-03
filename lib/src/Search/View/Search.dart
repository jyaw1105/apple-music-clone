import 'package:apple_music_clone/model/Genre.dart';
import 'package:apple_music_clone/src/Search/Bloc/bloc.dart';
import 'package:apple_music_clone/src/Search/Bloc/event.dart';
import 'package:apple_music_clone/src/Search/Bloc/state.dart';
import 'package:apple_music_clone/src/Search/View/TransitionAppBar.dart';
import 'package:apple_music_clone/src/SearchResult/View/SeachResultWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_grid/responsive_grid.dart';

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with AutomaticKeepAliveClientMixin {
  SearchBloc bloc = SearchBloc();

  ValueNotifier<bool> showAppBar = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    bloc.add(SearchInitEvent());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider<SearchBloc>(
        create: (_) => bloc,
        child: BlocListener<SearchBloc, SearchState>(
            listener: (context, state) {
          // if (state is HomeInitFailed) {
          //   SmartDialog.showToast(state.message);
          // }
        }, child: BlocBuilder<SearchBloc, SearchState>(
                builder: (context, SearchState state) {
          return Scaffold(
              body: SafeArea(
            child: NotificationListener(
              onNotification: (ScrollNotification scrollInfo) {
                if (scrollInfo.metrics.axis == Axis.vertical) {
                  showAppBar.value =
                      scrollInfo.metrics.pixels >= kToolbarHeight;
                  return true;
                }
                return false;
              },
              child: Scrollbar(
                child: CustomScrollView(
                  slivers: [
                    TransitionAppBar(
                        searchController: state.searchController,
                        searchOnSubmitted: (String value) {
                          bloc.add(OnSearchDoneEvent());
                        },
                        searchFocusNode: state.searchFocusNode,
                        cancelOnTap: () {
                          bloc.add(OffSearchEvent());
                        }),

                    // SliverList(
                    //     delegate: SliverChildListDelegate([

                    // ])),
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: state is SearchOnState
                          ? Text("Searching")
                          : state is SearchResultsState
                              ? SearchResultWidget(data: state.searchResults)
                              : ((state.genres ?? []).isNotEmpty)
                                  ? Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ResponsiveGridRow(
                                        children: state.genres!
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
                                                                  .circular(
                                                                      8.0)),
                                                      margin:
                                                          EdgeInsets.all(5.0),
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
              ),
            ),
          ));
        })));
  }

  @override
  bool get wantKeepAlive => true;
}
