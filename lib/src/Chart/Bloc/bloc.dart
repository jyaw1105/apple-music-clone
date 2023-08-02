import 'package:apple_music_clone/model/Playlists.dart';
import 'package:apple_music_clone/service/appleMusic/AppleMusicService.dart';
import 'package:apple_music_clone/src/Chart/Bloc/state.dart';
import 'package:apple_music_clone/src/Chart/View/DescriptionModal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'event.dart';

class ChartBloc extends Bloc<ChartEvent, ChartState> {
  final AppleMusicService appleMusicService = AppleMusicService();

  ChartBloc() : super(ChartState()) {
    on<GetDataByType>(_mapGetDataByTypeToEvent);
    on<GetDataByHref>(_mapGetDataByHrefToEvent);
    on<DescriptionOnTap>(_mapDescriptionOnTapToEvent);
    on<MoreOnTap>(_mapMoreOnTapToEvent);
  }

  void _mapMoreOnTapToEvent(MoreOnTap event, Emitter<ChartState> emit) async {}

  void _mapGetDataByTypeToEvent(
      GetDataByType event, Emitter<ChartState> emit) async {
    if ((event.href ?? '').isNotEmpty) {
      emit(state.copyWith(playlists: event.playlists));
      add(GetDataByHref(href: event.href!));
    } else {
      emit(state.copyWith(errorMessage: "href is empty"));
    }
  }

  void _mapGetDataByHrefToEvent(
      GetDataByHref event, Emitter<ChartState> emit) async {
    try {
      Playlists playlists = await appleMusicService.getDataByHref(event.href);
      emit(state.copyWith(playlists: playlists, title: state.title));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  void _mapDescriptionOnTapToEvent(
      DescriptionOnTap event, Emitter<ChartState> emit) async {
    Get.bottomSheet(
      DescriptionModal(playlists: state.playlists!),
      ignoreSafeArea: false,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
    );
  }
}
