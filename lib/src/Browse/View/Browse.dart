import 'dart:ui';

import 'package:apple_music_clone/model/Playlists.dart';
import 'package:apple_music_clone/src/Browse/Bloc/bloc.dart';
import 'package:apple_music_clone/src/Browse/Bloc/event.dart';
import 'package:apple_music_clone/src/Browse/Bloc/state.dart';
import 'package:apple_music_clone/src/Browse/View/src/GridPlaylists.dart';
import 'package:apple_music_clone/src/Browse/View/src/Storefront.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BrowsePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BrowserPageState();
}

class _BrowserPageState extends State<BrowsePage>
    with AutomaticKeepAliveClientMixin {
  BrowseBloc bloc = BrowseBloc();

  ValueNotifier<bool> showAppBar = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    bloc.add(FetchData());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider<BrowseBloc>(
        create: (_) => bloc,
        child: BlocListener<BrowseBloc, BrowseState>(
            listener: (context, state) {
          // if (state is HomeInitFailed) {
          //   SmartDialog.showToast(state.message);
          // }
        }, child: BlocBuilder<BrowseBloc, BrowseState>(
                builder: (context, BrowseState state) {
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
                    SliverAppBar(
                      backgroundColor: Colors.black.withOpacity(0.78),
                      elevation: 0.0,
                      title: ValueListenableBuilder(
                          valueListenable: showAppBar,
                          builder: (context, bool value, __) {
                            return AnimatedOpacity(
                              opacity: value ? 1.0 : 0.0,
                              duration: Duration(milliseconds: 300),
                              child: Stack(
                                children: [
                                  Positioned.fill(
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(
                                          sigmaX: 10.0, sigmaY: 10.0),
                                      child: Container(
                                        height: double.infinity,
                                      ),
                                    ),
                                  ),
                                  Text("Browse"),
                                ],
                              ),
                            );
                          }),
                      pinned: true,
                    ),
                    if ((state.storefronts ?? []).isNotEmpty)
                      SliverToBoxAdapter(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              constraints:
                                  BoxConstraints(minHeight: kToolbarHeight),
                              margin: const EdgeInsets.only(bottom: 10.0),
                              padding: EdgeInsets.symmetric(horizontal: 25),
                              child: Text(
                                "Browse",
                                style: TextStyle(
                                    fontSize: 32,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            StorefrontWidget(
                                playlistOnTap: playlistOnTap,
                                playlists: state.storefronts!)
                          ],
                        ),
                      ),
                    SliverPadding(padding: EdgeInsets.symmetric(vertical: 20)),
                    if ((state.mostPlaylists ?? []).isNotEmpty)
                      SliverToBoxAdapter(
                        child: Column(
                          children: [
                            Padding(
                                padding: EdgeInsets.symmetric(horizontal: 25),
                                child: GestureDetector(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: Row(
                                      children: [
                                        Flexible(
                                            child: Text(
                                          "Play the Hits",
                                          style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold),
                                        )),
                                        Icon(
                                          Icons.chevron_right_rounded,
                                          size: 38,
                                          color: Theme.of(context).hintColor,
                                        )
                                      ],
                                    ),
                                  ),
                                  onTap: () {},
                                )),
                            SizedBox(height: 5),
                            GridPlaylistsWidget(
                              playlistOnTap: playlistOnTap,
                              playlists: state.mostPlaylists ?? [],
                              row: 2,
                            )
                          ],
                        ),
                      ),
                    SliverPadding(padding: EdgeInsets.symmetric(vertical: 20)),
                    if ((state.charts?.cityCharts ?? []).isNotEmpty)
                      SliverToBoxAdapter(
                        child: Column(
                          children: [
                            Padding(
                                padding: EdgeInsets.symmetric(horizontal: 25),
                                child: GestureDetector(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: Row(
                                      children: [
                                        Flexible(
                                            child: Text(
                                          "City Charts",
                                          style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold),
                                        )),
                                        Icon(
                                          Icons.chevron_right_rounded,
                                          size: 38,
                                          color: Theme.of(context).hintColor,
                                        )
                                      ],
                                    ),
                                  ),
                                  onTap: () {},
                                )),
                            SizedBox(height: 5),
                            GridPlaylistsWidget(
                              playlistOnTap: playlistOnTap,
                              playlists:
                                  state.charts?.cityCharts?[0].data ?? [],
                            )
                          ],
                        ),
                      ),
                    SliverPadding(padding: EdgeInsets.symmetric(vertical: 20)),
                    if ((state.charts?.dailyGlobalTopCharts ?? []).isNotEmpty)
                      SliverToBoxAdapter(
                        child: Column(
                          children: [
                            Padding(
                                padding: EdgeInsets.symmetric(horizontal: 25),
                                child: GestureDetector(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: Row(
                                      children: [
                                        Flexible(
                                            child: Text(
                                          "Daily Top 100",
                                          style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold),
                                        )),
                                        Icon(
                                          Icons.chevron_right_rounded,
                                          size: 38,
                                          color: Theme.of(context).hintColor,
                                        )
                                      ],
                                    ),
                                  ),
                                  onTap: () {},
                                )),
                            SizedBox(height: 5),
                            GridPlaylistsWidget(
                              playlistOnTap: playlistOnTap,
                              playlists:
                                  state.charts?.dailyGlobalTopCharts?[0].data ??
                                      [],
                            )
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ));
        })));
  }

  void playlistOnTap(Playlists playlists) {
    bloc.add(PlaylistOnTap(playlists: playlists));
  }

  @override
  bool get wantKeepAlive => true;
}
