import 'package:apple_music_clone/core/app_export.dart';
import 'package:apple_music_clone/model/ChartResponse.dart';
import 'package:apple_music_clone/model/Playlists.dart';
import 'package:apple_music_clone/service/appleMusic/AppleMusicService.dart';
import 'package:apple_music_clone/src/Browse/Bloc/event.dart';
import 'package:apple_music_clone/src/Browse/Bloc/state.dart';
import 'package:apple_music_clone/src/Chart/chart_page_screen.dart';
import 'package:apple_music_clone/src/Home/controller/home_page_controller.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BrowseBloc extends Bloc<BrowseEvent, BrowseState> {
  BrowseBloc() : super(BrowseState()) {
    on<PlaylistOnTap>(_mapPlaylistOnTapToEvent);
    on<FetchData>(_mapFetchDataToEvent);
    on<FetchStorefront>(_mapFetchStorefrontEvent);
    on<FetchMostPlaylists>(_mapFetchMostPlaylistsEvent);
  }

  final AppleMusicService appleMusicService = AppleMusicService();
  void _mapFetchStorefrontEvent(
      FetchStorefront event, Emitter<BrowseState> emit) async {
    ChartResponse chartResponse = await appleMusicService.getEditorial();
    Playlists storefront = await appleMusicService.getStorefrontPlaylist();
    List<Playlists> playlists = [];
    if ((chartResponse.playlists ?? []).isNotEmpty) {
      playlists.addAll(chartResponse.playlists!.first.data);
    }
    playlists.insert(0, storefront);
    emit(state.copyWith(
        charts: chartResponse, storefront: storefront, storefronts: playlists));
  }

  void _mapFetchMostPlaylistsEvent(
      FetchMostPlaylists event, Emitter<BrowseState> emit) async {
    List<Playlists> mostPlaylists =
        await appleMusicService.getMostPlayedPlaylist(limit: 32);

    emit(state.copyWith(mostPlaylists: mostPlaylists));
  }

  void _mapFetchDataToEvent(FetchData event, Emitter<BrowseState> emit) async {
    add(FetchStorefront());
    add(FetchMostPlaylists());
  }

  void _mapPlaylistOnTapToEvent(
      PlaylistOnTap event, Emitter<BrowseState> emit) async {
    HomePageController homePageController = Get.find<HomePageController>();
    int index = homePageController.pageIndex.value;
    Navigator.of(homePageController.navigatorKeys[index].currentState!.context)
        .push(
      MaterialPageRoute(
        builder: (_) => ChartPage(
          href: event.playlists.href,
          playlists: event.playlists,
        ),
      ),
    );
    // Get.toNamed(AppRoutes.chartScreen, arguments: {
    //   'href': event.playlists.href,
    //   'playlists': event.playlists
    // });
  }
}
